import SwiftUI
import IdVerification365id


@objc public class MyCustomAnimations: NSObject {

    @objc public static func createMyCustomAnimations()  -> IdVerification.Animations {

        let animations = IdVerification.Animations()

        animations.instructionDocument = Text("Place your custom \ndocument animation here")
        animations.prepareDocument = Text("Place your custom \ndocument animation here")

        animations.instructionId3 = Text("Place your custom\npassport animation here")
        animations.prepareId3 = Text("Place your custom\npassport animation here")

        return animations
    }
}
