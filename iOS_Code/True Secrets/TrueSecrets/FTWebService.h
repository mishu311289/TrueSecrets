//
//  FTWebService.h
//  AvotraITS
//
//  Created by Martin Lalev on 12/27/10.
//  Copyright 2010 mART. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FTAppDelegate.h"
#import "FTSOAPResultParser.h"



typedef enum {
	FTRequestTypeSOAP, FTRequestTypePost, FTRequestTypeJSON, FTRequestTypeGet
}FTRequestType;
@interface FTWebService : NSObject
{
    
}
@property(nonatomic,retain)NSString *devicesToken;;
@property(nonatomic,retain)FTWebService *dt;


//+(NSString *)getDeviceID:(NSString *)devicesStr;
+ (FTRequestType) parseRequestType:(NSString*)type;

+ (NSString*) getBodyStringForType:(FTRequestType)type andParams:(NSDictionary*)params;
+ (NSDictionary*) getHeadersForType:(FTRequestType)type andParams:(NSDictionary*)params andDefaultHeaders:(NSDictionary*)headers;
+ (NSString*) getContentTypeForType:(FTRequestType)type andParams:(NSDictionary*)params;


+ (NSMutableURLRequest*) getRequestForURL:(NSString*)url andType:(NSString*)type andBodyData:(NSData*)data andContentType:(NSString*)contentType andHeaders:(NSDictionary*)headers andCookies:(NSDictionary*)cookieValues;
+ (NSMutableURLRequest*) getRequestForURL:(NSString*)url andType:(NSString*)type andBodyString:(NSString*)data andContentType:(NSString*)contentType andHeaders:(NSDictionary*)headers andCookies:(NSDictionary*)cookieValues;
+ (NSMutableURLRequest*) getRequestForType:(FTRequestType)type andURL:(NSString*)url andParams:(NSDictionary*)params andCookies:(NSDictionary*)cookieValues andHeaders:(NSDictionary*)headers;


+ (NSString*) resultForRequestWithType:(FTRequestType)type andURL:(NSString*)url andParams:(NSDictionary*)params andCookies:(NSDictionary*)cookieValues andHeaders:(NSDictionary*)headers responseHeaders:(NSDictionary**)responseHeaders responseCookies:(NSDictionary**)cookies;
+ (id) resultForURL:(NSString*)url andType:(NSString*)rt andReceiver:(NSString*)receiveType andInput:(id)input andParameters:(NSMutableDictionary*)parameters andCookies:(NSMutableDictionary*)cookies andHeaders:(NSMutableDictionary*)headers andParseSelector:(NSString*)parseSelector andParseTarget:(id)parseTarget andTokenData:(NSDictionary*)tokensSources;

@end
