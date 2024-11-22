

//
//  FTWebService.m
//  AvotraITS
//
//  Created by Martin Lalev on 12/27/10.
//  Copyright 2010 mART. All rights reserved.
//
#define INNERDATAFILE [FTCommon normalizeFilename:@"Documents/InnerData.plist"]
#import "FTWebService.h"
//#import "FTURLConnection.h"

@implementation FTWebService

@synthesize dt;
@synthesize devicesToken;

+ (FTRequestType) parseRequestType:(NSString*)type {

	if ([type isEqualToString:@"SOAP"])
        return 0;
	if ([type isEqualToString:@"Post"])
        return 1;
	if ([type isEqualToString:@"JSON"])
        return 2;
	if ([type isEqualToString:@"Get"]) 
        return 3;
	return -1;
}
+ (NSString*) getBodyStringForType:(FTRequestType)type andParams:(NSDictionary*)params {
	NSMutableString *requestString = [NSMutableString stringWithString:@""];
	
	if (type == FTRequestTypeSOAP)
	{
		NSString* methodName = [params objectForKey:@"MethodName"];
		[requestString appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
		[requestString appendString:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"];
		[requestString appendString:@"	<soap:Body>"];
		[requestString appendFormat:@"		<%@ xmlns=\"http://tempuri.org/\">", methodName];
		
		for (NSString* key in [params allKeys])
			if (![key isEqualToString:@"MethodName"])
				[requestString appendFormat:@"<%@>%@</%@>",key,[[params objectForKey:key] description],key];
		
		[requestString appendFormat:@"</%@>", methodName];
		[requestString appendString:@"</soap:Body>"];
		[requestString appendString:@"</soap:Envelope>"];
	}
	if (type == FTRequestTypePost)
	{
		for (NSString* key in [params allKeys])
        {
			[requestString appendFormat:@"&%@=%@", key, [params objectForKey:key]];
            NSLog(@"requestString543231:%@",requestString);
        }
        
		requestString = [NSMutableString stringWithString:[requestString substringFromIndex:1]];
        NSLog(@"requestString123%@",requestString);
	}
	if (type == FTRequestTypeJSON)
	{
		requestString = [NSMutableString stringWithString:[params JSONRepresentation]];
	}
	NSLog(@"requestString:%@",requestString);
	return requestString;
}
+ (NSDictionary*) getHeadersForType:(FTRequestType)type andParams:(NSDictionary*)params andDefaultHeaders:(NSDictionary*)headers {
	NSMutableDictionary* headersDict = [NSMutableDictionary dictionaryWithDictionary:headers];
	
	if (type  == FTRequestTypeSOAP)
	{
		[headersDict setObject:[NSString stringWithFormat:@"\"http://tempuri.org/%@\"", [params objectForKey:@"MethodName"]] forKey:@"SOAPAction"];		
	}
	
	return headersDict;
}
+ (NSString*) getContentTypeForType:(FTRequestType)type andParams:(NSDictionary*)params {
	NSString* ct = @"";
	
	if (type  == FTRequestTypeSOAP)
	{
		ct = @"text/xml; charset=utf-8";
	}
	
	return ct;
}


+ (NSMutableURLRequest*) getRequestForURL:(NSString*)url andType:(NSString*)type andBodyData:(NSData*)data andContentType:(NSString*)contentType andHeaders:(NSDictionary*)headers andCookies:(NSDictionary*)cookieValues {
    NSLog(@"data:%@",data);
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
	
	//NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:3];
	
	
	NSMutableArray* cookies = [NSMutableArray array];
	for (NSString* cookieKey in [cookieValues allKeys])
		[cookies addObject:
			[NSHTTPCookie cookieWithProperties:
				[NSDictionary dictionaryWithObjectsAndKeys:
					url, NSHTTPCookieOriginURL,
					cookieKey, NSHTTPCookieName,
					[cookieValues objectForKey:cookieKey], NSHTTPCookieValue,
					nil
				 ]
			 ]
		 ];
	NSDictionary *cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];

	
	
	
	NSMutableDictionary *hs = [NSMutableDictionary dictionaryWithDictionary:cookieHeaders];
	
	for (NSString* headerKey in [headers allKeys])
		[hs
		 setValue:	[headers objectForKey:headerKey]
		 forKey:	headerKey];
	
	[hs
	 setValue:	contentType
	 forKey:	@"Content-Type"];
	
	[hs
	 setValue:	[NSString stringWithFormat:@"%d",[data length]]
	 forKey:	@"Content-Length"];

	
	
	
	[request setAllHTTPHeaderFields:hs];
	
	[request
	 setHTTPMethod:		type];
	
	[request
	 setHTTPBody:		data];
	
	NSLog(@"request:%@",request);
	return request;
}
+ (NSMutableURLRequest*) getRequestForURL:(NSString*)url andType:(NSString*)type andBodyString:(NSString*)data andContentType:(NSString*)contentType andHeaders:(NSDictionary*)headers andCookies:(NSDictionary*)cookieValues {
	NSData *requestData = [NSData dataWithBytes:[data UTF8String] length:[data length]];
	return [self getRequestForURL:url andType:type andBodyData:requestData andContentType:contentType andHeaders:headers andCookies:cookieValues];
}
+ (NSMutableURLRequest*) getRequestForType:(FTRequestType)type andURL:(NSString*)url andParams:(NSDictionary*)params andCookies:(NSDictionary*)cookieValues andHeaders:(NSDictionary*)headers {
	NSString* requestType = @"POST";
	if (type == FTRequestTypeGet) {
		requestType = @"GET";
		NSString* urlRequest = @"";
		for (NSString* key in [params allKeys])
			urlRequest = [urlRequest stringByAppendingFormat:@"&%@=%@",key,[params objectForKey:key]];
		
		if ([urlRequest length] > 0)
		{
			url = [url stringByAppendingString:@"?"];
			url = [url stringByAppendingString:[urlRequest substringFromIndex:1]];
		}
	}
	return [self
			getRequestForURL:url
			andType:requestType
			andBodyString:[self getBodyStringForType:type andParams:params]
			andContentType:[self getContentTypeForType:type andParams:params]
			andHeaders:[self getHeadersForType:type andParams:params andDefaultHeaders:headers]
			andCookies:cookieValues
			];
	
}
-(id)stringCheck
{
    
    return 0;
    
}

//+(NSString *)getDeviceID:(NSString *)devicesStr
//{
//    NSLog(@"devicesStr:%@",devicesStr);
//    
//    
//     NSString *method=[[NSString alloc] initWithString:@"PDALogin"];
//        NSString *phoneNum = [FTAction readValueFromFile:INNERDATAFILE andInnerPath:@"PhoneNum"];
//    NSRange endRange=[devicesStr rangeOfString:@">"];
//        NSString *str_deciveToken=[devicesStr substringFromIndex:endRange.location];
//        NSLog(@"str_deciveToken:%@",str_deciveToken);
//    
//        str_deciveToken =[str_deciveToken stringByReplacingOccurrencesOfString:@">" withString:@""];
//    NSLog(@"str_deciveToken:%@",str_deciveToken);
//        NSMutableDictionary* paramsAJ = [NSMutableDictionary dictionary];
//        [paramsAJ setObject:method forKey:@"MethodName"];
//        [paramsAJ setObject:phoneNum forKey:@"phoneNo"];
//        [paramsAJ setObject:str_deciveToken forKey:@"deviceId"];
//        NSLog(@"%@",paramsAJ);
//
//    return str_deciveToken;
////    return [FTWebService resultForRequestWithType:FTRequestTypeSOAP andURL:@"http://mws.nameserverkatie.com/ws/mws.asmx" andParams:paramsAJ andCookies:[NSDictionary dictionary]andHeaders:[NSDictionary dictionary] responseHeaders:nil responseCookies:nil];
//    
//    
//}

+ (NSString*) resultForRequestWithType:(FTRequestType)type andURL:(NSString*)url andParams:(NSDictionary*)params andCookies:(NSDictionary*)cookieValues andHeaders:(NSDictionary*)headers responseHeaders:(NSDictionary**)responseHeaders responseCookies:(NSDictionary**)responseCookies {
 
  
  
    
    NSMutableURLRequest* req;
    NSLog(@"Params1234%@",params);
    

    
    
    
 
  
           
           
                       
                   
         


  
   
        req = [FTWebService getRequestForType:type andURL:url andParams:params andCookies:cookieValues andHeaders:headers];
 
	NSHTTPURLResponse* response;
	NSData* dataResult = nil;
	
	
	dataResult = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:nil];
	
	if (!dataResult)
    {
        if(responseCookies)
            (*responseCookies) = nil;
        if(responseHeaders)
            (*responseHeaders) = nil;
        return nil;
    }
    
   	
	NSDictionary* rh = [response allHeaderFields];
	if (responseHeaders)
		*responseHeaders = rh;
	NSString* stringResult = [[NSString alloc] initWithData:dataResult encoding:NSASCIIStringEncoding];
   
    NSLog(@"-------------------");
    NSLog(@"stringResult12345:%@",stringResult);
    NSLog(@"-------------------");

	if (type == FTRequestTypeSOAP)
	{
		stringResult = [FTSOAPResultParser parseString:stringResult forElement:[params objectForKey:@"MethodName"]];
        NSLog(@"stringResultShashi:%@",stringResult);
	}
	NSArray* cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:rh forURL:[NSURL URLWithString:NSHTTPCookieOriginURL]];
	NSMutableDictionary* rc = [NSMutableDictionary dictionary];
	for (NSHTTPCookie* cookie in cookies)
		[rc setObject:[cookie value] forKey:[cookie name]];
	if (responseCookies)
		*responseCookies = rc;
	
    NSLog(@"****************Response frm server***************");
    
    NSLog(@"stringResult54321%@",stringResult);
    
    NSLog(@"*********************************************");

    
    
    
	return stringResult;
}
//+ (id) resultForURL:(NSString*)url andType:(NSString*)rt andReceiver:(NSString*)receiveType andInput:(id)input andParameters:(NSMutableDictionary*)parameters andCookies:(NSMutableDictionary*)cookies andHeaders:(NSMutableDictionary*)headers andParseSelector:(NSString*)parseSelector andParseTarget:(id)parseTarget andTokenData:(NSDictionary*)tokensSources
//{
//	id resultSource = nil;
//	FTRequestType requestType = [FTWebService parseRequestType:rt];
//	
//	NSMutableDictionary* tokensData = [NSMutableDictionary dictionary];
//	if (input)
//		[tokensData setObject:input forKey:@"INPUT"];
//	
//	for (NSString* srcKey in [tokensSources allKeys])
//	{
//		id srcValue = [tokensSources objectForKey:srcKey];
//		
//		if (theSrc)
//			[tokensData setObject:theSrc forKey:srcKey];
//	}
//	
//	
//	
//	
//	NSDictionary* responseCookies;
//	NSDictionary* responseHeaders;
//	NSString* response = [FTWebService resultForRequestWithType:requestType andURL:url andParams:parameters andCookies:cookies andHeaders:headers responseHeaders:&responseHeaders responseCookies:&responseCookies];
//    NSLog(@"response:%@",response);
//	
//	if (!parseTarget)
//		parseTarget = [FTAppDelegate sharedAppDelegate].Main;
//	SEL sel = NSSelectorFromString(parseSelector);
//	if (sel)
//	{
//		NSMethodSignature* ms = [[parseTarget class] instanceMethodSignatureForSelector:sel];
//		NSInvocation* inv = [NSInvocation invocationWithMethodSignature:ms];
//		
//		[inv setSelector:sel];
//		[inv setTarget:parseTarget];
//		[inv setArgument:&response atIndex:2];
//		[inv setArgument:&responseHeaders atIndex:3];
//		[inv setArgument:&responseCookies atIndex:4];
//		[inv invoke];
//		[inv getReturnValue:&resultSource];
//		
//	}
//	else
//		resultSource = [FTCommon parse:response forFormat:receiveType];
//	return resultSource;
//}




@end
