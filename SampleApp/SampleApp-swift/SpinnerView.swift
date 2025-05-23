import SwiftUI

struct SpinnerView: View {
    var body: some View {
        VStack(spacing: 10) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())

            Text("The SDK is closing—releasing resources, please wait...")
                .font(.headline)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SpinnerView()
}
