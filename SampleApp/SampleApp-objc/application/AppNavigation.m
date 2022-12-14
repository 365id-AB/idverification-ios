#import "AppNavigation.h"

@interface AppNavigation ()

@end

@implementation AppNavigation

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    [self setNavigationBarHidden:true];
    return self;
}

+ (void)pushView:(UIViewController *)viewController {
    UINavigationController *navigationController = [self getInstance];
    if (navigationController == nil) {
        return;
    }
    [navigationController pushViewController:viewController animated:true];
}

+ (void)popView {
    UINavigationController *navigationController = [self getInstance];
    if (navigationController == nil) {
        return;
    }
    if (navigationController.viewControllers.count > 1) {
        return;
    }
    [navigationController popViewControllerAnimated:true];
}

+ (UINavigationController*)getInstance {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (window == nil) {
        return nil;
    }
    UIViewController *rootView = window.rootViewController;
    if(![rootView isKindOfClass:[UINavigationController class]]) {
        return nil;
    }
    UINavigationController *navigationController = (UINavigationController *)rootView;
    return navigationController;
}

@end
