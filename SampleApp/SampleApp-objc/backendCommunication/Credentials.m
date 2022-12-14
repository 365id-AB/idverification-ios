#import "Credentials.h"

@interface Credentials ()

@end

/// This class is purely used for demostration purposes.
/// Normally this should be handled different in the Customer implementation.
/// The license key should never be present on the User device.
/// Rather this should be handled in the implementing customer backend.
@implementation Credentials

// NOTE This should be populated by the customer, further information should be found in the SDK documentation.
static NSString *clientSecret = @"";
static NSString *clientId = @"";

+ (NSString *)clientSecret {
    return clientSecret;
}

+ (NSString *)clientId {
    return clientId;
}

@end
