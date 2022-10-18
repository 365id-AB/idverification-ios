import Foundation

/// This entire class is used to isolate the retrieval of the session token that needs to be provided to the startSDK function.
///
/// Note: on a production application the communication with the 365id server should be handled by the customer backend for added security.
class DeviceInformation {

    static var shared = DeviceInformation()
    
    var locationName: String = ""   // NOTE This should be populated by the customer
    var locationId: String = ""     // NOTE This should be populated by the customer
    var token: String = ""
    var refreshToken: String = ""

    /// Returns the information needed by the SDK to perform a transaction.
    func getInfo() -> [String : String] {
        self.refreshTheToken()

        return [
            "LocationName": locationName,
            "LocationId": locationId,
            "Token": token,
        ]
    }

    private func getToken() {
        do {
            let result = try GrpcCommunicator.sharedInstance()
                .authenticate(licenseKey: Credentials.shared.licenseKey)

            self.token = result.0
            self.refreshToken = result.1

        } catch {
            print("Failed to receive the message from 365id server [Authenticate]: \(error)")
            return
        }
    }

    private func refreshTheToken() {
        if self.refreshToken == "" {
            getToken()
            return
        }

        do {
            let result = try GrpcCommunicator.sharedInstance()
                .refresh(refreshToken: self.refreshToken, token: self.token)

            self.token = result.0
            self.refreshToken = result.1

        } catch {
            print("Failed to receive the message from 365id server [refreshToken]: \(error)")
            return
        }
    }
}
