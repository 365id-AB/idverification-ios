import SwiftUI
import IdVerification365id

struct ContentView: View {

    @State var shouldShowSDKView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Sample Application\n\n365id Id Verification SDK")
                    .multilineTextAlignment(.center)

                Spacer()
                NavigationLink(destination: SdkMainView(showAppBar: false), isActive: $shouldShowSDKView) {
                    Button("Enter 365id SDK") {
                        getTokenAndStartSDK()
                    }
                }
                Spacer()
            }
        }
        .preferredColorScheme(nil) 
        .onChange(of: shouldShowSDKView) { value in
            if !value {
                // This call to stopSDK is made when the user press the back button in the
                // Navigation view. This could leed to multiple calls to stopSDK, which is safe to do.
                stopSDK()
            }
        }
    }

    /// Used to kickstart the SDK and register a callback that interacts with the user interface
    private func getTokenAndStartSDK() {
        if startSDK(deviceInfo: DeviceInformation.shared.getInfo(), callBack: { result in

            let status = result.Status

            switch status {
                case .OK:
                    // This is returned when a transaction completes successfully
                    // Note: This does not mean the user identity or supplied document is verified,
                    // only that the transaction process itself did not end prematurely.
                    // The assessment shows a summary
                    // Have a look at `result.Assessment` for more information
                    print("Successful result")

                case .Dismissed:
                    // This is returned if the user dismisses the SDK view prematurely.
                    print("User dismissed SDK")

                case .ClientException:
                    // This is returned if the SDK encountered an internal error.
                    // Please Report such issues to 365id as bugs!
                    print("Client has thrown an exception")

                case .ServerException:
                    // This is returned if there was an issue communicating with the 365id Backend.
                    // Could be a connectivity issue.
                    print("Server has thrown an exception")

                default:
                    // This should not occur
                    print("Unsupported status type was returned")
            }

            // Prints the entire result
            print("Result: \(result)")

            // Stops the SDK and releases the resources.
            stopSDK()

            // Makes the Navigation View Transition back from the SDK view
            self.shouldShowSDKView = false
        }) {
            // Makes the Navigation View transition to the SDK view
            self.shouldShowSDKView = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
