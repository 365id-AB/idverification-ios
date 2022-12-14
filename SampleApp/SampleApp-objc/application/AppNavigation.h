#import <UIKit/UIKit.h>

@interface AppNavigation : UINavigationController

+(void)pushView:(UIViewController*)viewController;
+(void)popView;

@end
