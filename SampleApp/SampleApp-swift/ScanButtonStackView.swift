import SwiftUI
import IdVerification365id

struct ScanButtonStackView: View {

    let eventDelegate: IdVerification365id.IdVerificationEventDelegate

    var body: some View {
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
                surfaceContainer: UIColor.lightGray,
                poweredByLogo: .STANDARD,
                animations: customAnimationViews
            )
        )
    }
}

#Preview {
    ScanButtonStackView(eventDelegate: SampleAppEventDelegate())
}
