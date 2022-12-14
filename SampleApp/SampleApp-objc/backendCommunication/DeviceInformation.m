#import "DeviceInformation.h"
#import "Credentials.h"
#import "TokenHandler.h"

@interface DeviceInformation ()

@end

/// This entire class is used to isolate the retrieval of the session token that needs to be provided to the startSDK function.
///
/// Note: on a production application the communication with the 365id server should be handled by the customer backend for added security.
@implementation DeviceInformation

/// Returns the information needed by the SDK to perform a transaction.
+ (void)getDeviceInfo:(completionHandlerInfo)completionHandler {
    [TokenHandler getToken:Credentials.clientSecret :Credentials.clientId :^(NSString *token) {
        NSDictionary *deviceInfo = @{
            @"Token":token ? token : @""
        };
        completionHandler(deviceInfo);
    }];
}

@end
