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

    func onStarted() {
        self.information = "Started\n"
        self.showSDKView = true
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

    @State var shouldShowSDKView: Bool = false
    @StateObject var eventDelegate: SampleAppEventDelegate = SampleAppEventDelegate()

    var body: some View {
        NavigationView {
            VStack {
                Text("Sample Application\n\n365id Id Verification SDK")
                    .multilineTextAlignment(.center)

                Spacer()
                NavigationLink(destination: SdkMainView(showAppBar: false), isActive: $eventDelegate.showSDKView) {
                    Button("Enter 365id SDK") {
                        getTokenAndStartSDK()
                    }
                }
                Spacer()
                Text("Event Log:\n\(eventDelegate.information)")
                Spacer()
            }
        }
        .preferredColorScheme(nil)
    }

    /// Used to kickstart the SDK and register a callback that interacts with the user interface
    private func getTokenAndStartSDK() {
        DeviceInformation.shared.getInfo { info in
            if !IdVerification.start(token: info["Token"]!, delegate: eventDelegate) {
                print("Unable to start the SDK, was the token provided properly?")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
