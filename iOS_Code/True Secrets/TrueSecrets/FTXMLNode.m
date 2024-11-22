//
//  FTXMLNode.m
//  AvotraITS
//
//  Created by Martin Lalev on 2/5/11.
//  Copyright 2011 mART. All rights reserved.
//

#import "FTXMLNode.h"


@implementation FTXMLNode

@synthesize Name;
@synthesize NamespaceURI;
@synthesize QualifiedName;
@synthesize Attributes;
@synthesize ParentNode;
@synthesize Value;
@synthesize Nodes;

- (NSString*) description
{
	NSMutableString* strResult = [NSMutableString string];
	[strResult appendString:self.Name];
	[strResult appendString:@" ::= {"];
	[strResult appendString:self.Value];
	[strResult appendString:@"}\n"];
	[strResult appendString:@"{\n"];
	for (FTXMLNode* node in self.Nodes)
		[strResult appendString:[node description]];
	[strResult appendString:@"}\n"];
	return strResult;
}

- (id) toObject {
	if ([self.Value length] > 0 || [self.Nodes count] == 0)
		return self.Value;
	else {
		NSMutableDictionary* rslt = [NSMutableDictionary dictionary];
		NSMutableArray* arr = [NSMutableArray array];
		NSString* arrayName = @"";
		
		for (FTXMLNode* node in self.Nodes)
		{
			id obj = [node toObject];
			
			if ([arrayName length] > 0)
			{
				[arr addObject:obj];
			}
			else
			{
				
				if ([[rslt allKeys] containsObject:node.Name])
				{
					arrayName = node.Name;
					[arr addObject:[rslt objectForKey:node.Name]];
					[arr addObject:obj];
				}
				else {
					[rslt setObject:obj forKey:node.Name];
				}

			}
		}
		
		if ([arrayName length] > 0)
			return arr;
		else {
			return rslt;
		}

	}
}

@end
