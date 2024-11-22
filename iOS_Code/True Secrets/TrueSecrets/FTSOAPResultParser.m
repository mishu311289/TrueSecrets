//
//  FTSOAPResultParser.m
//  AvotraITS
//
//  Created by Martin Lalev on 12/27/10.
//  Copyright 2010 mART. All rights reserved.
//

#import "FTSOAPResultParser.h"


@implementation FTSOAPResultParser

@synthesize elementFound;
@synthesize parsedSOAPResult;
@synthesize expectingSOAPElement;
@synthesize rootElement;
@synthesize currentElement;

- (id) initForElement:(NSString*)element
{
	if ([self init])
	{
		self.expectingSOAPElement = element;
	}
	return self;
}

+ (NSString*) parseData:(NSData*)data forElement:(NSString*)element
{
	FTSOAPResultParser* SRP = [[FTSOAPResultParser alloc] initForElement:element];
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
	[parser setDelegate:SRP];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	//[parser release];
	
	
	NSDictionary* envelope = [SRP.rootElement toObject];
	NSDictionary* body = [envelope objectForKey:@"soap:Body"];
	id ResponseObj = [body objectForKey:[NSString stringWithFormat:@"%@Response", element]];
	
	id ResultObj;
	if ([ResponseObj isKindOfClass:[NSString class]]) {
		ResultObj = nil;
	}
	else {
		ResultObj = [ResponseObj objectForKey:[NSString stringWithFormat:@"%@Result", element]];
	}
	
	
	
	if ([ResultObj isKindOfClass:[NSArray class]])
	{
		return [(NSArray*)ResultObj JSONRepresentation];
	}
	if ([ResultObj isKindOfClass:[NSDictionary class]])
	{
		return [(NSDictionary*)ResultObj JSONRepresentation];
	}
	else if ([ResultObj isKindOfClass:[NSString class]] || [ResultObj isKindOfClass:[NSNumber class]])
	{
		return [ResultObj description];
	}
	else {
		return nil;
	}
}
+ (NSString*) parseString:(NSString*)strData forElement:(NSString*)element
{
	return [FTSOAPResultParser parseData:[NSData dataWithBytes:[strData UTF8String] length:[strData length]] forElement:element];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	
	FTXMLNode* node = [[FTXMLNode alloc] init];
	
	node.Name = elementName;
	node.NamespaceURI = namespaceURI;
	node.QualifiedName = qName;
	node.Attributes = attributeDict;
	node.ParentNode = self.currentElement;
	node.Value = [NSMutableString string];
	node.Nodes = [NSMutableArray array];
	
	if (self.currentElement)
	{
		[self.currentElement.Nodes addObject:node];
	}
	
	self.currentElement = node;
	
	//[node release];
	
	
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if (self.currentElement.ParentNode)
		self.currentElement = self.currentElement.ParentNode;
	else
	{
		self.rootElement = self.currentElement;
		self.currentElement = nil;
	}
	//self.elementFound = NO;
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if (self.currentElement)
		[self.currentElement.Value appendString:string];
	
	
}

@end
