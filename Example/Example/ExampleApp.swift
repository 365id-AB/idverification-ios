import SwiftUI
import IdVerification365id

@main
struct ExampleApp: App {

    let licenseKey = Credentials.licenseKey
    @State var deviceInfo = [
        "LocationName": Credentials.LocationName,
        "LocationId": Credentials.LocationId,
        "Token": ""
    ]

    @State var isShowingSdkView = false
    @Environment(\.presentationMode) var presentationMode

    /// Generate an app token
    /// Start an 365id Verification SDK
    func generateToken() {

        do {
            self.deviceInfo["Token"] = try GRPCCommunicator.sharedInstance().getToken(licenseKey: licenseKey)
        } catch {
            print("Failed to receive the message from frontend [Get Token]: \(error)")
            return
        }

        if self.deviceInfo["Token"] == nil {
            self.isShowingSdkView = false
            print("Invalid App Token")
            return
        }

        // Start the SDK
        if startSDK(deviceInfo: self.deviceInfo, callBack: { result in
            /**
            * Callback
            */
            let transactionId = result.TransactionId
            let status = result.Status

            switch status {
                case .OK:
                    // This is returned when a transaction completes successfully 
                    // Note: This does not mean the user identity or supplied document is verified, 
                    // only that the transaction process itself did not end prematurely.
                    // The assessment shows a summary 
                    let assessment = result.Assessment
                    print("Successful result")

                case .Dismissed:
                    // This is returned if the user dismisses the SDK view prematurely.
                    print("User dismissed SDK")

                case .ClientException:
                    // This is returned if the SDK encountered an internal error. Report such 
                    // issues to 365id as bugs!
                    print("Client has thrown an exception")

                case .ServerException:
                    // This is returned if there was an issue talking to 365id Cloud services. 
                    // Could be a connectivity issue.
                    print("Server has thrown an exception")

                default:
                    // This should not occur
                    print("Not supported status type was returned")
            }

            // Prints the entire result
            print("Result: \(result)")

            // Stops the SDK and de-allocates the resources
            stopSDK()

            // Disables the SDK view in example app
            self.isShowingSdkView = false

            // Dismisses the SDK view
            DispatchQueue.main.async {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            // Enables the SDK view in example app
            self.isShowingSdkView = true
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    NavigationLink(destination: ContentView(),
                                   isActive: $isShowingSdkView) {
                        Button("Scan Document") {
                            generateToken()
                        }
                    }
                }
            }
        }
    }
}
