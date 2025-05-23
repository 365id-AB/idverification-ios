import SwiftUI
import IdVerification365id

struct ContentView: View {

    @StateObject var eventDelegate: SampleAppEventDelegate = SampleAppEventDelegate()

    var body: some View {
            VStack {
                Text("Sample Application\n\n365id Id Verification SDK")
                    .multilineTextAlignment(.center)
                    .font(.title3)

                Spacer()

                NavigationLink(destination: IdVerificationContainerView(), isActive: $eventDelegate.showSDKView) {
                    VStack {
                        if eventDelegate.showSpinner {
                            SpinnerView()
                        } else {
                            ScanButtonStackView(eventDelegate: eventDelegate)
                        }
                    }
                }

                Spacer()

                if !eventDelegate.showSpinner {
                    Text("Event Log:\n\(eventDelegate.information)")
                }

                Spacer()
            }
            .navigationBarHidden(true)
            .preferredColorScheme(nil)
    }
}

#Preview {
    ContentView()
}
