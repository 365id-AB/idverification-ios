# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [1.5.8] - 2023-01-16

### Fixed

Automatic detection takes long time to detect the document.

## [1.5.7] - 2023-01-13

### Fixed

Stop sending the unwanted logs to sentry.

## [1.5.6] - 2023-01-12

### Fixed

Updated sentry log to version 7.31.5

## [1.5.5] - 2023-01-11

### Fixed

Added swift-flag for target 365id sdk.

## [1.5.4] - 2023-01-11

### Fixed

Added checks in communication to not allow a response to go through after stopping the SDK.

## [1.4.4] - 2023-01-11

### Fixed

Added checks in communication to not allow a response to go through after stopping the SDK.

## [1.5.3] - 2023-01-10

### Added

Added Sentry to the SDK.

## [1.5.2] - 2023-01-10

### Added

Added support for custom White Labeling of the SDK.

## [1.5.1] - 2023-01-03

### Fixed

Fixed Protobuf build in xcode toolchain - Project can now handle all proto-files without custom edit.

## [1.4.3] - 2022-12-22

### Fixed

Close GRPC channel immediately.

## [1.4.2] - 2022-12-22

### Fixed 

Added a check for transaction id before sending the result to the called app.

## [1.5.0] - 2022-12-15

### Fixed

Using DispatchQueue to manage the execution of tasks serially or concurrently.

## [1.4.1] - 2022-12-13

### Fixed

Fixed the NFC animation wasn't reloading.

## [1.4.0] - 2022-12-09

### Added

Added a simplified start function

## [1.3.12] - 2022-12-06

### Fixed

Liveness result is replaced by a spinner.
Handled the situation when LocationName and LocationId is not set in the SDK.

## [1.3.11] - 2022-12-01

### Fixed

Fixed the crash related to closing the GRPC channel.

### Added

Added comunication retries on every comunication point

## [1.3.10] - 2022-11-30

### Fixed

Removed the public access level from `enum ProgressSpinningViewType`.

## [1.3.9] - 2022-11-30

### Added

There are now retries performed when there are communication issues.

## [1.3.8] - 2022-11-30

### Fixed

SDK views does not reload if the there is consecutive FRONT_SIDE tasks.

## [1.3.7] - 2022-11-29

### Added

Send a skipe nfc message if the device does not support NFC or the user skips it.

## [1.3.6] - 2022-11-29

### Fixed

Stopped the SDK from being able to store a previously captured image.

## [1.3.5] - 2022-11-29

### Added

Implement task InvalidVersion. Same logic as NoActivePackage.

## [1.3.4] - 2022-11-28

### Fixed

Make the spinners and symbols the same size. 

## [1.3.3] - 2022-11-25

### Fixed

Only shows iproov statustext when finished. Added new default loading animation and iproov animation. 

## [1.3.2] - 2022-11-24

### Fixed

Fixed the scan button which is hidden on iPads.

## [1.3.1] - 2022-11-24

### Fixed

Fixated the versions of the internal swift package dependencies

## [1.3.0] - 2022-11-23

### Added

Added compatibility with Objective-C

## [1.2.26] - 2022-11-22

### Fixed

Fixed the binary incompatibility between Xcode version in release.

## [1.2.25] - 2022-11-21

### Changed

Show the result after iProov completed for at least 1.5 second.

## [1.2.24] - 2022-11-15

### Fixed

Prints an error log while loading the Font Awesome font.

## [1.2.23] - 2022-11-10

### Changed

Implement NoActivePackage behaviour.
Returns the result callback with proper user message
Updated the session contract with ios sdk version number and the platform.

## [1.2.22] - 2022-11-07

### Changed

Removed the callbacks for transaction model.
Added an idDetectionProcessor to handles the id detection for camera frame. 
Rewritten the test cases for transaction model and processors.
Vibrate the device when NFC is detected.

### Fixed

Camera video streamming does not show on the viewfinder when scans the backside of the document

## [1.2.21] - 2022-11-02

### Changed

Merge tag 1.2.20 with master branch.

### Fixed

In the debug build the root certificates was unnecessarily cleared

## [1.2.20] - 2022-11-01

### Fixed

Implemented an animation to hide camera appearance.

## [1.2.19] - 2022-10-31

### Fixed

Added checks to properly unwrap optional values.
Removed the callbacks for transaction model.
Added an idDetectionProcessor to handles the id detection for camera frame. 
Rewritten the test cases for transaction model and processors.
Vibrate the device when NFC is detected.

## [1.2.17] - 2022-10-28

### Fixed

Build SDK for distribution was set to NO.

### Changed

Updated the detection library to version 1.1.13

## [1.2.16] - 2022-10-21

### Fixed

Backside flip animation
Communication channel was not checked for nil value. 

## [1.2.15] - 2022-10-19

### Fixed

Textcontainer has missing text on the backside task

## [1.2.14] - 2022-10-19

### Changed

Added timeout (20 seconds) for GRPC communication.
Added a container view for iProov and removed the MBProgressHUD

## [1.2.13] - 2022-10-07

### Fixed

Fixed NFC crash issue.

## [1.2.12] - 2022-10-07

### Fixed

Removed the callbacks for iProov.
Changed the NFC part no not use callbacks but instead a Pub/Sub solution.

## [1.2.11] - 2022-09-29

### Fixed

Often SDK plays the shutter sound when the back button is pressed

## [1.2.10] - 2022-09-23

### Changed

Revert the changes for text container view.
Added fastlane

## [1.2.9] - 2022-09-22

### Changed

Removed the callbacks from cameraModel, Instead switched to a publisher subscriber solution.

## [1.2.8] - 2022-09-16

### Changed

Allow to call the StartSDKMainView before calling the startSDK().


## [1.2.7] - 2022-09-14

### Changed

Updated the detection library to version 1.1.11

## [1.2.6] - 2022-09-12

### Fixed

Fixed the bug for capturing front and backside sometimes it does not continue.

## [1.2.5] - 2022-09-08

### Fixed

Fixed font not loaded correctly.
Fixed dialog offset not calculated correctly.

### Changed

Updated the id detection library to version 1.1.10-rc5

## [1.2.4] - 2022-09-06

### Fixed

Fixed the Lottie animation offset.
Fixed the viewfinder alignment.
Fixed the debug roi orientation.

### Changed

Updated the id detection cv version into 1.1.10-rc2

## [1.2.2] - 2022-08-19

### Fixed

Fixed the issue for nfc connection lost.

## [1.2.1] - 2022-08-04

### Changed

Updated .gitlab-ci.yml file to publish the ios sdk framework into ios example project.

## [1.2.0] - 2022-08-03

### Added

SDK returns true if the session token is received from the frontend successfully otherwise false.

### Fixed

Fixed the issue for SDK often shows Undefined view.

## [1.1.4] - 2022-08-02

### Fixed

Fixed Appbar back button which does not work with iPhone8.

## [1.1.3] - 2022-07-27

### Changed

Ignore the detection if the auto focus is not enable

## [1.1.2] - 2022-07-25

### Changed

Removed superfluous IdTransactionResult and simplified the code a bit.  
Updated version of Id Detection Library to 1.1.9  

## [1.1.1] - 2022-07-13

### Fixed

Fixed lottie animation for processing document doesn't appear while sending the image to frontend
and the text box is showing even though an image has been captured and uploaded.

## [1.1.0] - 2022-07-12

### Added

Autofocus point is now placed in the viewfinder.

### Fixed

Devices without 4K camera support is now supported.

## [1.0.5] - 2022-07-06

### Fixed

Removed hard-coded gRPC certificates and updated iProof proto file.

## [1.0.4] - 2022-07-05

### Fixed

Fixed an issue with publishing the app to testFlight.

## [1.0.1] - 2022-06-28

### Fixed

Fixed an issue with importing the SDK into scannerapp.

## [1.0.0] - 2022-06-27

### Fixed

Fixed an issue with third party dependencies inside a XCFramework through SPM


## [0.2.15] - 2022-06-22

### Added

Implement an iProov

### Fixed

Removed the text which displays in waiting view

## [0.2.14] - 2022-06-16

### Fixed

Fixed the bug for showing last captured image while stating the SDK

## [0.2.13] - 2022-06-13

### Fixed

Memory leak happening when the preview view was created in the wrong place.

### Changed

Updated the IdDetectionCV framework to version 1.1.2

## [0.2.12] - 2022-06-09

### Added

Send information about the way the images are captured to the identification request

## [0.2.11] - 2022-06-04

### Added

Added debug information to the viewfinder

## [0.2.10] - 2022-06-03

### Fixed

Removed the payload check when gets the next task.

## [0.2.9] - 2022-06-02

### Added

Implemented uploading debug images and ROI when "AllowDebugging" claim is present in token.

## [0.2.8] - 2022-06-01

### Added

Implemented an animation view for NFC.

## [0.2.7] - 2022-06-01

### Added

Implemented support for handling BACK_SIDE task and consecutive FRONT_SIDE tasks.

## [0.2.6] - 20222-04-28

### Added

Implemented an animation for ContainerView.

## [0.2.5] - 20222-04-26

### Fixed

Clear the photocapture handler when exiting the sdk.

## [0.2.4] - 20222-04-26

### Fixed

Updated new viewfinder

### Added

Updated the IdDetectionCV framework 1.0.1 (Fix for the passports are rotated upside down) 

## [0.2.3] - 20222-04-13

### Fixed

Sending the scanning response to the scanner app twice

### Added

Implemented a new viewfinder 

## [0.2.2] - 20222-04-13

### Fixed

No fixes made.

### Added

No additions made.

### Changed

Marked IddetectionCV and Lottie as "internal" to the framework

## [0.2.1] - 20222-04-08

### Fixed

No fixes made.

### Added

No additions made.

### Changed

Updated the IdDetectionCV to version 1.0.0

## [0.2.0] - 20222-04-08

### Fixed

No fixes made.

### Added.

No additions made.

### Changed

Updated the IdDetectionCV framework to version 0.1.2

## [0.1.10] - 2022-03-30

### Fixed

No Fixes.

### Added

No Additions.

### Changed

Changed the animation in the waiting view.

## [0.1.9] - 2022-03-23

### Fixed

Camera stays active after existing the ios framework

### Added

Start the camera early.
Improved the auto focus on camera.
Added sound and vibrate when picture is taken.

## [0.1.8] - 2022-03-07

### Fixed

No Fixes

### Added

Implementation of SDK to accept the appToken instaead of licensekey

## [0.1.7] - 2022-03-01

Implemented a ci-pipeline

### Added

Implemented a ci-pipeline for ios sdk.
Pushed the debug/release framework into 365id Cocoa pods repository.

### Changed

No changes has been made

### Fixed

No fixes

## [0.1.5] - 2022-02-25

Bug fixes

### Added

No changes has added

### Changed

No changes has been made

### Fixed

Switch of the camera while exit the ios sdk.
Fixed the crashes when swapping from ios sdk to scanner app.

## [0.1.0] - 2022-02-21

This is the first internal release of the framework with a version.

### Added

The first internal release of the framework!

### Changed

The first release made, so far everything has had changes.

### Fixed

The first release made, no fixes yet.

