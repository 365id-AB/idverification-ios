# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [1.1.5] - 2022-08-03

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

