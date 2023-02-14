#import "ViewController.h"
#import "DeviceInformation.h"
#import "IdVerification365id/IdVerification365id-Swift.h"
#import "AppNavigation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blueColor;

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
        if ([IdVerification startWithDeviceInfo:deviceInfo callBack:^(TransactionResult *result) {

            StatusType status = result.Status;

            switch(status) {
                case StatusTypeOK:
                    // This is returned when a transaction completes successfully
                    // Note: This does not mean the user identity or supplied document is verified,
                    // only that the transaction process itself did not end prematurely.
                    // The assessment shows a summary
                    // Have a look at `result.Assessment` for more information
                    NSLog(@"Successful result");
                    break;
                case StatusTypeDismissed:
                    // This is returned if the user dismisses the SDK view prematurely.
                    NSLog(@"User dismissed SDK");
                    break;
                case StatusTypeClientException:
                    // This is returned if the SDK encountered an internal error.
                    // Please Report such issues to 365id as bugs!
                    NSLog(@"Client has thrown an exception");
                    break;
                case StatusTypeServerException:
                    // This is returned if there was an issue communicating with the 365id Backend.
                    // Could be a connectivity issue.
                    NSLog(@"Server has thrown an exception");
                    break;
                default:
                    // This should not occur
                    NSLog(@"Unsupported status type was returned");
                    break;
            }

            // Prints the entire result
            NSLog(@"Result :%@", result);

            // Stops the SDK and releases the resources.
            [IdVerification stop];

            // Makes the Navigation View Transition back from the SDK view
            [self showSdkView:false];
        }]) {
            // Makes the Navigation View transition to the SDK view
            [self showSdkView:true];
        }
    }];
}

@end
