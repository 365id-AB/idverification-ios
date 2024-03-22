# Custom Theme
 
You can use `IdVerification.setCustomTheme()` to apply a specific set of colors.  
Most of the parameters of this function are optional (except `poweredByLogo` and `showAppBar`), so you can use only those that suits you. Below you see an example of how you can use this function:

```swift
IdVerification.setCustomTheme(
   IdVerificationTheme(
         surface: UIColor.white,
         onSurface: UIColor.purple,
         surfaceVariant: UIColor.black,
         background: UIColor.white,
         primary: UIColor.purple,
         onPrimary: UIColor.white,
         primaryContainer: UIColor.gray,
         onPrimaryContainer: UIColor.yellow,
         secondary: UIColor.white,
         onSecondary: UIColor.purple,
         secondaryContainer: UIColor.lightGray,
         onSecondaryContainer: UIColor.darkGray,
         tertiary: UIColor.black,
         onTertiary: UIColor.green,
         appBarLogo: nil,
         poweredByLogo: .STANDARD,
         showAppBar: false,
         animations: IdVerification.Animations()))
```

Below you will find images showing which color variables are applied to certain elements in the SDK.

## Information View

<img src="./images/info-view.png"  width="500" height="500">

## Camera View

<img src="./images/camera-view.png"  width="500" height="500">

## NFC View

<img src="./images/nfc-view.png"  width="500" height="500">

## iProov View

<img src="./images/iProov-view.png"  width="500" height="500">

## Wait View

<img src="./images/wait-view.png"  width="500" height="500">

You can use `IdVerification.Animations()` to set custom animations for preparation, loading and instructions.
```swift
IdVerification.Animations(
      public var prepareId3: any View
      public var prepareId1Frontside: any View
      public var prepareId1Backside: any View 
      public var prepareDocument: any View
      public var prepareNfc: any View
      public var prepareFaceMatch: any View 

      public var instructionId3: any View
      public var instructionId1Frontside: any View
      public var instructionId1Backside: any View
      public var instructionDocument: any View
      public var instructionNfc: any View 

      public var loadingImageCapture: any View
      public var loadingNfc: any View
      public var loadingFaceMatch: any View
      public var loadingGeneric: any View
```

- The prepare animations are shown before the step is to be performed.
- The instruction animations are shown during the step.
- The loading animations are shown after the step is performed.  

<br/>

Here is an example of how to override the default animations, in this case by replacing a few of them with `ExampleLoadingSpinner()`.  

```swift

// You can use IdVerification.Animations() to set custom animations for preparation, loading and instructions.
let customAnimations = IdVerification.Animations()

// The prepare animations are shown before the step is to be performed.
customAnimations.prepareDocument = ExampleLoadingSpinner()
customAnimations.prepareId3 = ExampleLoadingSpinner()

// The instruction animations are shown during the step.
customAnimations.instructionDocument = CustomAnimation()
customAnimations.instructionId3 = CustomAnimation()

// The loading animations are shown after the step is performed.
customAnimations.loadingNfc = Image("myCustomAnimation")

IdVerification.setCustomTheme(
   IdVerificationTheme(
         surface: UIColor.white,
         onSurface: UIColor.purple,
         surfaceVariant: UIColor.black,
         background: UIColor.white,
         primary: UIColor.purple,
         onPrimary: UIColor.white,
         primaryContainer: UIColor.gray,
         onPrimaryContainer: UIColor.yellow,
         secondary: UIColor.white,
         onSecondary: UIColor.purple,
         secondaryContainer: UIColor.lightGray,
         onSecondaryContainer: UIColor.darkGray,
         tertiary: UIColor.black,
         onTertiary: UIColor.green,
         appBarLogo: nil,
         poweredByLogo: .STANDARD,
         showAppBar: false,
         animations: customAnimations))
```