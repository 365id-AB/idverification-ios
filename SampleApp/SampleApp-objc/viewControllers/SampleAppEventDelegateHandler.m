#import "SampleAppEventDelegateHandler.h"
#import "DeviceInformation.h"
#import "ViewController.h"

@implementation IdVerificationHandler

- (instancetype)initWithPresenter:(UIViewController *)presentingVC {
    self = [super init];
    if (self) {
        _presentingViewController = presentingVC;
    }
    return self;
}

- (void)startVerificationWithDocumentSize:(DocumentSizeType)documentSizeType {
    [DeviceInformation getDeviceInfo:^(NSDictionary *deviceInfo) {
        IdVerificationSkipModules *skipNoModules = [[IdVerificationSkipModules alloc] init];

        if ([IdVerification startWithToken:deviceInfo[@"Token"]
                                 locationId:0
                                skipModules:skipNoModules
                          documentSizeType:documentSizeType
                                  delegate:self]) {
            NSLog(@"IdVerification SDK started successfully.");
        } else {
            NSLog(@"Failed to start IdVerification SDK.");
        }
    }];
}

- (void)showSdkView:(BOOL)value {
    if (value) {
        UIViewController *vc = [IdVerification createMainView];
        vc.navigationController.navigationBarHidden = YES;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.presentingViewController presentViewController:vc animated:YES completion:nil];
    } else {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        [IdVerification stop];
    }
}

- (void)sendStatusToViewController:(NSString *)result {
    if ([self.presentingViewController respondsToSelector:@selector(updateTransactionResult:)]) {
        [(id)self.presentingViewController updateTransactionResult:result];
    }
}

#pragma mark - IdVerificationEventDelegate

- (void)onStarted {
    NSLog(@"EventDelegate - Started.");

    // Reset previous transaction result
    if ([self.presentingViewController respondsToSelector:@selector(updateTransactionResult:)]) {
        [(id)self.presentingViewController resetTransactionResult];
    }

    [self sendStatusToViewController:@"STARTED"];
    [self showSdkView:YES];
}

- (void)onTransactionCreated:(NSString * _Nonnull)transactionId {
    NSLog(@"EventDelegate - Transaction is created: %@.", transactionId);

    NSString *message = [NSString stringWithFormat:@"TransactionId: %@", transactionId];
    [self sendStatusToViewController:message];
}

- (void)onDocumentFeedback:(enum DocumentType)documentType countryCode:(NSString * _Nonnull)countryCode {
    NSLog(@"EventDelegate - The document identification process has completed.");

    NSString *message = [NSString stringWithFormat:@"Document feedback: %ld %@", (long)documentType, countryCode];
    [self sendStatusToViewController:message];
}

- (void)onNfcFeedback:(enum NfcFeedback)nfcFeedback expiryDate:(NSString * _Nonnull)expiryDate {
    NSLog(@"EventDelegate - The Nfc process has completed..");

    NSString *message = [NSString stringWithFormat:@"Nfc feedback: %ld %@", (long)nfcFeedback, expiryDate];
    [self sendStatusToViewController:message];
}

- (void)onFaceMatchFeedback:(enum FaceMatchFeedback)facematchFeedback {
    NSLog(@"EventDelegate - The face match process has completed..");

    NSString *message = [NSString stringWithFormat:@"Face match feedback: %ld", (long)facematchFeedback];
    [self sendStatusToViewController:message];
}

- (void)onUserDismissed {
    NSLog(@"EventDelegate - User Dismissed.");

    NSString *message = [NSString stringWithFormat:@"DISMISSED by the user."];
    [self sendStatusToViewController:message];
    
    // Show spinner
    if ([self.presentingViewController respondsToSelector:@selector(showSpinner:)]) {
        [(id)self.presentingViewController showSpinner:YES];
    }

    [self showSdkView:NO];
    [IdVerification stop];
}

- (void)onClosed {
    NSLog(@"EventDelegate - The SDK was closed and its resources have been released.");
    
    // Stop showing the spinner
    if ([self.presentingViewController respondsToSelector:@selector(showSpinner:)]) {
        [(id)self.presentingViewController showSpinner:NO];
    }

    NSString *message = [NSString stringWithFormat:@"CLOSED"];
    [self sendStatusToViewController:message];
}

- (void)onCompleted:(IdVerificationResult * _Nonnull)result {
    NSLog(@"EventDelegate - Completed. Transaction id is %@.", result.transactionId);
    
    NSString *message = [NSString stringWithFormat:@"COMPLETED. Result %@", result.transactionId];
    [self sendStatusToViewController:message];

    [self showSdkView:NO];
    [IdVerification stop];
}

- (void)onError:(IdVerificationErrorBundle * _Nonnull)error {
    NSLog(@"EventDelegate - Error.");

    NSString *message = [NSString stringWithFormat:@"ERROR\n %@\n %ld\n", error.message, (long)error.error];
    [self sendStatusToViewController:message];

    [self showSdkView:NO];
    [IdVerification stop];
}

@end
