import Foundation

/// This entire class is used to isolate the retrieval of the session token that needs to be provided to the startSDK function.
///
/// Note: on a production application the communication with the 365id server should be handled by the customer backend for added security.
class DeviceInformation {

    static var shared = DeviceInformation()
    
    var locationName: String = ""   // NOTE This should be populated by the customer
    var locationId: String = ""     // NOTE This should be populated by the customer

    /// Returns the information needed by the SDK to perform a transaction.
    func getInfo(_ completionHandler: @escaping (_ info: [String : String]) -> Void) {
        TokenHandler.getToken(
            clientSecret: Credentials.shared.clientSecret,
            clientId: Credentials.shared.clientId
        ) { token in
            completionHandler([
                "LocationName": DeviceInformation.shared.locationName,
                "LocationId": DeviceInformation.shared.locationId,
                "Token": token ?? "",
            ])
        }
    }
}
