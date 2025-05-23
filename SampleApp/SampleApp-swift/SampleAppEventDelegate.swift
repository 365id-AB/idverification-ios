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
    @Published var showSpinner: Bool = false

    /// Called when SDK has finished initializing and is ready to be displayed on the device.
    func onStarted() {
        DispatchQueue.main.async {
            self.information = "Started\n"
            self.showSDKView = true
        }
    }

    /// Called when the transaction is created.
    func onTransactionCreated(_ transactionId: String) {
        DispatchQueue.main.async {
            self.information += "TransactionId\n\(transactionId)\n"
        }
    }

    /// Called when the document identification process has completed.
    func onDocumentFeedback(_ documentType: DocumentType, countryCode: String) {
        DispatchQueue.main.async {
            self.information += "Document feedback\n\(documentType)\n\(countryCode)\n"
        }
    }

    /// Called when the nfc process has completed.
    func onNfcFeedback(_ feedback: NfcFeedback, expiryDate: String) {
        DispatchQueue.main.async {
            self.information += "Nfc feedback\n\(feedback)\n\(expiryDate)\n"
        }
    }

    /// Called when the face match process has completed.
    func onFaceMatchFeedback(_ feedback: FaceMatchFeedback) {
        DispatchQueue.main.async {
            self.information += "Face match feedback\n\(feedback)\n"
        }
    }

    /// Called when the user exits the SDK using the back or cancel button.
    func onUserDismissed() {
        DispatchQueue.main.async {
            self.information += "Dismissed by the user.\n"
            self.showSDKView = false
            self.showSpinner = true
        }
        IdVerification.stop()
    }

    /// Called when all remaining resources tied to the SDK instance has been cleaned up.
    func onClosed() {
        DispatchQueue.main.async {
            self.information += "SDK CLOSED\n"
            self.showSpinner = false
        }
    }

    /// Called when there is an error with the sdk. A verification transaction can not be recovered after this call is
    /// recieved.
    func onError(_ error: IdVerificationErrorBundle) {
        DispatchQueue.main.async {
            self.information += "ERROR\n\(error.message)\n\(error.error)\n"
            self.showSDKView = false
            self.showSpinner = true
        }
        IdVerification.stop()
    }

    /// Called when the id verification process has completed
    func onCompleted(_ result: IdVerificationResult) {
        DispatchQueue.main.async {
            self.information += "RESULT\n\(result.transactionId)\n"
            self.showSDKView = false
            self.showSpinner = true
        }
        IdVerification.stop()
    }
}
