import Foundation

/// This class is purely used for demostration purposes.
/// Normally this should be handled different in the Customer implementation.
/// The license key should never be present on the User device.
/// Rather this should be handled in the implementing customer backend.
class Credentials {
    static var shared = Credentials()

    // NOTE This should be populated by the customer, further information should be found in the SDK documentation.
    let clientSecret = ""
    let clientId: String = ""
}
