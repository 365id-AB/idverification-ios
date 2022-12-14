#import <UIKit/UIKit.h>

@interface DeviceInformation : NSObject

typedef void(^completionHandlerInfo)(NSDictionary* deviceInfo);
+(void)getDeviceInfo:(completionHandlerInfo)completionHandler;;

@end
