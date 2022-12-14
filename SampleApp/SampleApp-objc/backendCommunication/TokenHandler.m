#import "TokenHandler.h"

@interface TokenHandler ()

@end

@implementation TokenHandler

@synthesize clientSecret = _clientSecret;
@synthesize clientId = _clientId;

static NSString *baseUrl = @"https://eu.customer.365id.com/api/v1/";
const NSInteger minimumSecondsToUseToken = 25;
static NSString *storedTokenDataKey = @"TokenData365ID";

- (id)initWithData
    :(NSString*)accessToken
    :(NSString*)expiresIn
    :(NSString*)refreshToken
    :(NSString*)expireTimeTxt
    :(NSString*)clientSecret
    :(NSString*)clientId
{
    self = [super init];
    self.accessToken = accessToken;
    self.expiresIn = expiresIn;
    self.refreshToken = refreshToken;
    self.expireTimeTxt = expireTimeTxt;
    self.clientSecret = clientSecret;
    self.clientId = clientId;
    return self;
}

- (NSString*)getAccessToken {
    return self.accessToken;
}

- (NSString*)getRefreshToken {
    return self.refreshToken;
}

- (void)setExpireTimeTxt {
    NSInteger useSeconds;
    if (self.expiresIn == nil) {
        useSeconds = 0;
    }
    else {
        NSInteger expiresInInteger = [self.expiresIn integerValue];
        useSeconds = expiresInInteger;
    }
    NSDate *expireTime = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitSecond value:useSeconds toDate:[[NSDate alloc] init] options:0];
    if (expireTime == nil) {
        return;
    }
    NSDateFormatter *dateFormatter = [self getDateFormatter];
    NSString *result = [dateFormatter stringFromDate:expireTime];
    self.expireTimeTxt = result;
}

- (void)setClientSecret:(NSString *)value {
    _clientSecret = value;
}

- (void)setClientId:(NSString *)value {
    _clientId = value;
}

- (NSString*)getClientSecret {
    return _clientSecret;
}

- (NSString*)getClientId {
    return _clientId;
}

/** Get a UTC date formatter */
- (NSDateFormatter*)getDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    if (timeZone != nil) {
        [dateFormatter setTimeZone:timeZone];
    }
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return dateFormatter;
}

/** Get seconds left of active token */
- (NSInteger)getTokenSecondsLeft {
    NSString *dateTxt = self.expireTimeTxt;
    if (dateTxt == nil) {
        return 0;
    }
    NSDateFormatter *dateFormatter = [self getDateFormatter];
    NSDate *futureDate = [dateFormatter dateFromString:dateTxt];
    if (futureDate == nil) {
        return 0;
    }
    NSDateComponents *dateComponents = [NSCalendar.currentCalendar components:NSCalendarUnitSecond fromDate:[[NSDate alloc] init] toDate:futureDate options:0];
    NSInteger secondsLeft;
    if (dateComponents != nil) {
        secondsLeft = dateComponents.second;
    }
    else {
        secondsLeft = 0;
    }
    if (secondsLeft < 0) {
        secondsLeft = 0;
    }
    return secondsLeft;
}

/** Check if the token is valid based on the expire date */
- (BOOL)isValidToken {
    NSInteger secondsLeft = [self getTokenSecondsLeft];
    BOOL result = secondsLeft >= minimumSecondsToUseToken;
    return result;
}

/** Create TokenData object from json */
+ (TokenHandler*)jsonToTokenData:(NSString *)json {
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData == nil) {
        return nil;
    }
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
        return nil;
    }
    NSString *accessToken = [dict objectForKey:@"access_token"];
    NSString *expiresInTxt = [dict objectForKey:@"expires_in"];
    NSString *refreshToken = [dict objectForKey:@"refresh_token"];
    NSString *expireTimeTxt = [dict objectForKey:@"expireTimeTxt"];
    NSString *clientSecret = [dict objectForKey:@"clientSecret"];
    NSString *clientId = [dict objectForKey:@"clientId"];
    TokenHandler *tokenHandler = [[TokenHandler alloc] initWithData:accessToken :expiresInTxt :refreshToken :expireTimeTxt :clientSecret :clientId];
    return tokenHandler;
}

/** Create json from TokenData object */
+ (NSString*)tokenDataToJson:(TokenHandler *)tokenData {
    NSDictionary *details = @{
        @"access_token":tokenData.accessToken,
        @"expires_in":tokenData.expiresIn,
        @"refresh_token":tokenData.refreshToken,
        @"expireTimeTxt":tokenData.expireTimeTxt,
        @"clientSecret":tokenData.clientSecret,
        @"clientId":tokenData.clientId,
    };
    NSError *parseError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:details options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError != nil) {
        return nil;
    }
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

/** Save the TokenData on the device */
+ (BOOL)save
    :(NSString*)clientSecret
    :(NSString*)clientId
    :(NSString*)responseBody
{
    TokenHandler *tokenData = [self jsonToTokenData:responseBody];
    if (tokenData == nil) {
        return false;
    }
    [tokenData setExpireTimeTxt];
    [tokenData setClientId:clientId];
    [tokenData setClientSecret:clientSecret];
    NSString *updatedJson = [self tokenDataToJson:tokenData];
    if (updatedJson == nil) {
        return false;
    }
    [NSUserDefaults.standardUserDefaults setValue:updatedJson forKey:storedTokenDataKey];
    return true;
}

/** Load the TokenData from the device */
+ (TokenHandler*)loadData {
    NSString *json = [NSUserDefaults.standardUserDefaults stringForKey:storedTokenDataKey];
    if (json == nil) {
        return nil;
    }
    TokenHandler *tokenData = [self jsonToTokenData:json];
    if (tokenData == nil) {
        [self delete];
        return nil;
    }
    return tokenData;
}

/** Delete the TokenData from the device */
+ (void)delete{
    [NSUserDefaults.standardUserDefaults removeObjectForKey:storedTokenDataKey];
}

/** Delete TokenData if Credentials has been changed */
+ (void)deleteIfCredentialsChanged
    :(NSString*)clientSecret
    :(NSString*)clientId
{
    TokenHandler *tokenData = [self loadData];
    if (tokenData == nil) {
        return;
    }
    NSString *storedClientId = [tokenData getClientId];
    NSString *storedClientSecret = [tokenData getClientSecret];
    if (![storedClientId isEqualToString:clientId] || ![storedClientSecret isEqualToString:clientSecret]) {
        [self delete];
    }
}

/** Get a token for starting the SDK */
+ (void)getToken
    :(NSString *)clientSecret
    :(NSString *)clientId
    :(completionHandlerType)completionHandler
{
    [self deleteIfCredentialsChanged:clientSecret :clientId];
    TokenHandler *storedTokenData = [self loadData];

    if (storedTokenData != nil) {
        NSInteger secondsLeft = [storedTokenData getTokenSecondsLeft];
        NSString *secondsLeftTxt = [NSString stringWithFormat: @"%ld", (long)secondsLeft];
        NSLog(@"getToken() - %@ seconds left of token.", secondsLeftTxt);
        if ([storedTokenData isValidToken]) {
            NSLog(@"getToken() - Using stored token.");
            completionHandler([storedTokenData getAccessToken]);
            return;
        }
    }

    NSString *action;
    NSDictionary *bodyParams;
    NSString *bearer;
    if (storedTokenData != nil) {
        action = @"refresh_token";
        bodyParams = @{
            @"refresh_token":[storedTokenData getRefreshToken]
        };
        bearer = [storedTokenData getAccessToken];
        [self delete];
    }
    else {
        action = @"access_token";
        bodyParams = @{
            @"client_id":clientId,
            @"client_secret":clientSecret
        };
        bearer = nil;
    }

    NSString *fullUrl = [NSString stringWithFormat:@"%@%@", baseUrl, action];
    NSURL *url = [[NSURL alloc] initWithString:fullUrl];
    if (url == nil) {
        completionHandler(nil);
        return;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.timeoutInterval = 5;
    request.HTTPMethod = @"POST";
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (bearer != nil) {
        NSString *bearerTxt = [NSString stringWithFormat:@"Bearer %@", bearer];
        [request setValue:bearerTxt forHTTPHeaderField:@"Authorization"];
    }
    NSError *parseParamsError;
    NSData *jsonParams = [NSJSONSerialization dataWithJSONObject:bodyParams options:NSJSONWritingPrettyPrinted error:&parseParamsError];
    if (parseParamsError != nil) {
        completionHandler(nil);
        return;
    }
    request.HTTPBody = jsonParams;
    [self runRequest:request :clientSecret :clientId :completionHandler];
}

/** Get a token for starting the SDK */
+ (void)runRequest
    :(NSMutableURLRequest *) request
    :(NSString *)clientSecret
    :(NSString *)clientId
    :(completionHandlerType)completionHandler
{
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpStatus = (NSHTTPURLResponse *)response;
        if (error != nil || httpStatus.statusCode != 200) {
            NSLog(@"getToken() - error:");
            NSLog(@"%@", error.localizedDescription);
            NSLog(@"%@", httpStatus.description);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil);
            });
            return;
        }

        NSError *parseError;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        if (parseError != nil || responseDictionary == nil) {
            NSLog(@"getToken() - error:");
            NSLog(@"%@", parseError.description);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil);
            });
            return;
        }

        NSError *parseDataError;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseDictionary options:NSJSONWritingPrettyPrinted error:&parseDataError];
        if (parseDataError != nil || jsonData == nil) {
            NSLog(@"getToken() - error:");
            NSLog(@"%@", parseDataError.description);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil);
            });
            return;
        }

        NSString *responseBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (responseBody == nil) {
            NSLog(@"getToken() - error: Could not store response json.");
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil);
            });
            return;
        }

        if (![self save:clientSecret :clientId :responseBody]) {
            NSLog(@"getToken() - error: Could not save response.");
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil);
            });
            return;
        }

        NSLog(@"getToken() - success!");
        dispatch_async(dispatch_get_main_queue(), ^{
            TokenHandler *newData = [self loadData];
            if (newData == nil) {
                completionHandler(nil);
            }
            else {
                completionHandler([newData getAccessToken]);
            }
        });
    }] resume];
}
@end
