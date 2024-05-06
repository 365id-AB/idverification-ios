import SwiftUI
import IdVerification365id

/// This is a very simple example on how the IdVerificationEventDelegate can be implemented
class SampleAppEventDelegate: IdVerificationEventDelegate, ObservableObject {

    @Published var showSDKView: Bool = false {
        didSet {
            guard self.showSDKView else {
                // The show SDKView was set to false, most likely by the user dismissing the view
                IdVerification.stop()
                return
            }
        }
    }
    @Published var information: String = ""

    /// Called when SDK has finished initializing and is ready to be displayed on the device.
    func onStarted() {
        self.information = "Started\n"
        self.showSDKView = true
    }

    /// Called when the transaction is created.
    func onTransactionCreated(_ transactionId: String) {
        self.information += "TransactionId\n\(transactionId)\n"
    }

    /// Called when the document identification process has completed.
    func onDocumentFeedback(_ documentType: DocumentType, countryCode: String) {
        self.information += "Document feedback\n\(documentType)\n\(countryCode)\n"
    }

    /// Called when the nfc process has completed.
    func onNfcFeedback(_ feedback: NfcFeedback, expiryDate: String) {
        self.information += "Nfc feedback\n\(feedback)\n\(expiryDate)\n"
    }

    /// Called when the face match process has completed.
    func onFaceMatchFeedback(_ feedback: FaceMatchFeedback) {
        self.information += "Face match feedback\n\(feedback)\n"
    }

    /// Called when the user exits the SDK using the back button in the 365id AppBar.
    func onUserDismissed() {
        self.information += "Dismissed by the user.\n"
        self.showSDKView = false
        IdVerification.stop()
    }

    /// Called when all remaining resources tied to the SDK instance has been cleaned up.
    func onClosed() {
        self.information += "SDK CLOSED\n"
    }

    /// Called when there is an error with the sdk. A verification transaction can not be recovered after this call is
    /// recieved.
    func onError(_ error: IdVerificationErrorBundle) {
        self.information += "ERROR\n\(error.message)\n\(error.error)\n"
        showSDKView = false
        IdVerification.stop()
    }

    /// Called when the id verification process has completed
    func onCompleted(_ result: IdVerificationResult) {
        self.information += "RESULT\n\(result.transactionId)\n"
        showSDKView = false
        IdVerification.stop()
    }
}

struct ContentView: View {

    @StateObject var eventDelegate: SampleAppEventDelegate = SampleAppEventDelegate()

    var body: some View {
            VStack {
                Text("Sample Application\n\n365id Id Verification SDK")
                    .multilineTextAlignment(.center)

                Spacer()
                NavigationLink(destination: IdVerificationContainerView(), isActive: $eventDelegate.showSDKView) {

                    VStack {
                        Spacer()
                            .frame(height: 30)
                        Button("Set Custom Theme") {
                           setCustomTheme()
                        }

                        Spacer()
                            .frame(height: 80)

                        Button("Scan Generic Document") {
                            getTokenAndStartSDK(documentSizeType: .document)
                        }
                        Spacer()
                            .frame(height: 30)
                        Button("Scan Id-card / Driving License") {
                            getTokenAndStartSDK(documentSizeType: .id1)
                        }
                        Spacer()
                            .frame(height: 30)
                        Button("Scan Passport") {
                            getTokenAndStartSDK(documentSizeType: .id3)
                        }
                        Spacer()
                            .frame(height: 30)
                        Button("Scan Odd Document") {
                            getTokenAndStartSDK(documentSizeType: .odd)
                        }
                        Spacer()
                            .frame(height: 30)
                    }
                }
                Spacer()
                Text("Event Log:\n\(eventDelegate.information)")
                Spacer()
            }
            .navigationBarHidden(true)
            .preferredColorScheme(nil)
    }

    /// Used to kickstart the SDK and register a callback that interacts with the user interface
    private func getTokenAndStartSDK(documentSizeType: DocumentSizeType = .document) {
        DeviceInformation.shared.getInfo { info in
            if !IdVerification.start(token: info["Token"]!,
                                     documentSizeType: documentSizeType,
                                     delegate: eventDelegate) {
                print("Unable to start the SDK, was the token provided properly?")
            }
        }
    }

    private func setCustomTheme() {

        let customAnimationViews = IdVerification.Animations()

        customAnimationViews.instructionDocument = Text("Place your custom \ndocument animation here")
        customAnimationViews.prepareDocument = Text("Place your custom \ndocument animation here")

        customAnimationViews.instructionId3 = Text("Place your custom\npassport animation here")
        customAnimationViews.prepareId3 = Text("Place your custom\npassport animation here")


        IdVerification.setCustomTheme(
            IdVerificationTheme(
                primary: UIColor.purple,
                onPrimary: UIColor.white,
                primaryContainer: UIColor.magenta,
                secondary: UIColor.gray,
                onSecondary: UIColor.darkGray,
                secondaryContainer: UIColor.lightGray,
                onSecondaryContainer: UIColor.darkGray,
                tertiary: UIColor.purple,
                onTertiary: UIColor.white,
                tertiaryContainer: UIColor.magenta,
                onTertiaryContainer: UIColor.white,
                surface: UIColor.white,
                onSurface: UIColor.black,
                onSurfaceVariant: UIColor.darkGray,
                inverseSurface: UIColor.black,
                inverseOnSurface: UIColor.white,
                poweredByLogo: .STANDARD,
                animations: customAnimationViews
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
