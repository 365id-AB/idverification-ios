#import <UIKit/UIKit.h>

@interface TokenHandler : NSObject

@property NSString* accessToken;
@property NSString* expiresIn;
@property NSString* refreshToken;
@property NSString* expireTimeTxt;
@property (nonatomic) NSString* clientSecret;
@property (nonatomic) NSString* clientId;

typedef void(^completionHandlerType)(NSString* token);
+(void)getToken
    :(NSString*)clientSecret
    :(NSString*)clientId
    :(completionHandlerType)completionHandler;
@end
