import SwiftUI
import IdVerification365id

struct ContentView: View {

    @Environment(\.presentationMode) var presentationMode
    @State private var showAppBar = false

    var body: some View {
        ZStack {
            SdkMainView(showAppBar: showAppBar)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems( // Back Button
            leading:
            Button {
                stopSDK()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text(Image(systemName: "xmark")) + Text("Back")
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
