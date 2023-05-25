import SwiftUI
import IdVerification365id

/// This view is used to show the 365id sdk view
struct IdVerificationContainerView: View {
    var body: some View {
        ZStack {
            SdkMainView()
        }
        .navigationBarHidden(true)
    }
}

struct IdVerificationContainerView_Previews: PreviewProvider {
    static var previews: some View {
        IdVerificationContainerView()
    }
}
