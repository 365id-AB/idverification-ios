#import <UIKit/UIKit.h>
#import "IdVerification365id/IdVerification365id-Swift.h"

@interface ViewController : UIViewController
- (void)updateTransactionResult:(NSString *)result;
- (void)resetTransactionResult;
- (void)showSpinner:(BOOL)isLoading;
@end

