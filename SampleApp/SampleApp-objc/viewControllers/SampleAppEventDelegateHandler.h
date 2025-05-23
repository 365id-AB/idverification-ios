#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IdVerification365id/IdVerification365id-Swift.h"

@interface IdVerificationHandler : NSObject <IdVerificationEventDelegate>

@property (nonatomic, weak) UIViewController *presentingViewController;

- (instancetype)initWithPresenter:(UIViewController *)presentingVC;
- (void)startVerificationWithDocumentSize:(DocumentSizeType)documentSizeType;

@end
