#import "AppDelegate.h"
#import "ViewController.h"
#import "AppNavigation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [[AppNavigation alloc] initWithRootViewController:[ViewController alloc]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
