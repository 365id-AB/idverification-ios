#import "ViewController.h"
#import "DeviceInformation.h"
#import "IdVerification365id/IdVerification365id-Swift.h"
#import "AppNavigation.h"

@interface ViewController () <IdVerificationEventDelegate>

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    // Make sure to stop the SDK when it is dismissed
    [super viewWillAppear:animated];
    [IdVerification stop];
    self.view.backgroundColor = UIColor.blueColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blueColor;

    self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;

    // Safe area View
    UIView *safeAreaView = [[UIView alloc] initWithFrame:CGRectZero];
    safeAreaView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:safeAreaView];
    safeAreaView.translatesAutoresizingMaskIntoConstraints = false;
    UILayoutGuide *safeGuide = self.view.safeAreaLayoutGuide;
    [safeAreaView.topAnchor constraintEqualToAnchor:safeGuide.topAnchor].active = true;
    [safeAreaView.leadingAnchor constraintEqualToAnchor:safeGuide.leadingAnchor].active = true;
    [safeAreaView.trailingAnchor constraintEqualToAnchor:safeGuide.trailingAnchor].active = true;
    [safeAreaView.bottomAnchor constraintEqualToAnchor:safeGuide.bottomAnchor].active = true;

    // Info label
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    infoLabel.textColor = UIColor.blackColor;
    infoLabel.numberOfLines = 0;
    infoLabel.text = @"Sample Application\n\n365id Id Verification SDK";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    [safeAreaView addSubview:infoLabel];
    infoLabel.translatesAutoresizingMaskIntoConstraints = false;

    // Start SDK Button
    UIButton *startSdkButton = [[UIButton alloc] initWithFrame:CGRectZero];
    startSdkButton.backgroundColor = UIColor.blueColor;
    [startSdkButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    startSdkButton.layer.cornerRadius = 10;
    [startSdkButton setTitle:@"Enter 365id SDK" forState:UIControlStateNormal];
    [safeAreaView addSubview:startSdkButton];
    startSdkButton.translatesAutoresizingMaskIntoConstraints = false;
    [startSdkButton addTarget:self action:@selector(clickStartSdkButton:) forControlEvents:UIControlEventTouchUpInside];

    // Set views in safe area
    NSDictionary *viewsDictionary = @{@"infoLabel":infoLabel, @"startSdkButton":startSdkButton};
    [safeAreaView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[infoLabel]-20-|" options:0 metrics:nil views:viewsDictionary]];
    [safeAreaView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[startSdkButton]-20-|" options:0 metrics:nil views:viewsDictionary]];
    [safeAreaView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[infoLabel]-40-[startSdkButton(40)]->=0-|" options:0 metrics:nil views:viewsDictionary]];
}

-(void)showSdkView:(BOOL)value {
    [AppNavigation popView];
    if (value) {
        UIViewController *sdkViewController = [IdVerification createMainViewWithShowAppBar:true];
        [AppNavigation pushView:sdkViewController];
    }
    else {
        // This call to stopSDK is made when the user press the back button in the
        // Navigation view. This could leed to multiple calls to stopSDK, which is safe to do.
        [IdVerification stop];
    }
}

-(void)clickStartSdkButton:(id)sender
{
    [DeviceInformation getDeviceInfo:^(NSDictionary *deviceInfo) {
        if([IdVerification startWithToken:deviceInfo[@"Token"] locationId:0 delegate: self]) {
            // SDK was happy with the provided arguments.
        } else {
            // Unable to start the SDK. Most likely something was wrong with the token.
        }
    }];
}

- (void)onClosed {
    NSLog(@"EventDelegate - The SDK was closed and its resources have been released.");
}

- (void)onCompleted:(IdVerificationResult * _Nonnull)result {
    NSLog(@"EventDelegate - Completed.");

    // Makes the Navigation View Transition back from the SDK view
    [self showSdkView:false];

    // Stops the SDK and releases the resources.
    [IdVerification stop];
}

- (void)onError:(IdVerificationErrorBundle * _Nonnull)error {
    NSLog(@"EventDelegate - Error.");

    // Makes the Navigation View Transition back from the SDK view
    [self showSdkView:false];

    // Stops the SDK and releases the resources.
    [IdVerification stop];
}

- (void)onStarted {
    // Makes the Navigation View transition to the SDK view
    [self showSdkView:true];
    NSLog(@"EventDelegate - Started.");
}

- (void)onUserDismissed {
    // Stops the SDK and releases the resources.
    NSLog(@"EventDelegate - User Dismissed.");

    // Makes the Navigation View Transition back from the SDK view
    [self showSdkView:false];

    [IdVerification stop];
}

@end
