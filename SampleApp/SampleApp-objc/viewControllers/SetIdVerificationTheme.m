#import "SetIdVerificationTheme.h"
#import "IdVerification365id/IdVerification365id-Swift.h"
#import "SampleApp_objc-Swift.h"
#import <UIKit/UIKit.h>

@implementation SetIdVerificationTheme

- (void)setCustomTheme {
    Animations  *animations = [MyCustomAnimations createMyCustomAnimations];

    IdVerificationTheme *theme = [[IdVerificationTheme alloc]
        initWithPrimary:UIColor.purpleColor
        onPrimary:UIColor.whiteColor
        primaryContainer:UIColor.magentaColor
        secondary:UIColor.grayColor
        onSecondary:UIColor.darkGrayColor
        secondaryContainer:UIColor.lightGrayColor
        onSecondaryContainer:UIColor.darkGrayColor
        tertiary:UIColor.purpleColor
        onTertiary:UIColor.whiteColor
        tertiaryContainer:UIColor.magentaColor
        onTertiaryContainer:UIColor.whiteColor
        surface:UIColor.whiteColor
        onSurface:UIColor.blackColor
        onSurfaceVariant:UIColor.darkGrayColor
        inverseSurface:UIColor.blackColor
        inverseOnSurface:UIColor.whiteColor
        surfaceContainer: UIColor.lightGrayColor
        poweredByLogo:(PoweredByLogoSTANDARD)
        animations:(animations)
    ];

    [IdVerification setCustomTheme:theme];
}

- (void)setDefaultTheme {
    Animations *animations = [[Animations alloc] init];
    IdVerificationTheme *theme = [[IdVerificationTheme alloc]
        initWithPrimary:nil
        onPrimary:nil
        primaryContainer:nil
        secondary:nil
        onSecondary:nil
        secondaryContainer:nil
        onSecondaryContainer:nil
        tertiary:nil
        onTertiary:nil
        tertiaryContainer:nil
        onTertiaryContainer:nil
        surface:nil
        onSurface:nil
        onSurfaceVariant:nil
        inverseSurface:nil
        inverseOnSurface:nil
        surfaceContainer:nil
        poweredByLogo:(PoweredByLogoSTANDARD)
        animations:animations
    ];

    [IdVerification setCustomTheme:theme];
}

@end
