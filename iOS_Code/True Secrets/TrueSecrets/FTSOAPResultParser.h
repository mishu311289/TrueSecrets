//
//  FTSOAPResultParser.h
//  AvotraITS
//
//  Created by Martin Lalev on 12/27/10.
//  Copyright 2010 mART. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTXMLNode.h"
#import "JSON.h"

@interface FTSOAPResultParser : NSObject<NSXMLParserDelegate> {
	NSMutableString* parsedSOAPResult;
	NSString* expectingSOAPElement;
	BOOL elementFound;
	FTXMLNode* rootElement;
	FTXMLNode* currentElement;
}

@property (nonatomic, retain) NSMutableString* parsedSOAPResult;
@property (nonatomic, retain) NSString* expectingSOAPElement;
@property (nonatomic, assign) BOOL elementFound;
@property (nonatomic, retain) FTXMLNode* rootElement;
@property (nonatomic, retain) FTXMLNode* currentElement;

- (id) initForElement:(NSString*)element;
+ (NSString*) parseData:(NSData*)data forElement:(NSString*)element;
+ (NSString*) parseString:(NSString*)strData forElement:(NSString*)element;

@end
