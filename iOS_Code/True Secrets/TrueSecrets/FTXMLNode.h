//
//  FTXMLNode.h
//  AvotraITS
//
//  Created by Martin Lalev on 2/5/11.
//  Copyright 2011 mART. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FTXMLNode : NSObject {
	NSString* Name;
	NSString* NamespaceURI;
	NSString* QualifiedName;
	NSDictionary* Attributes;
	FTXMLNode* ParentNode;
	NSMutableString* Value;
	NSMutableArray* Nodes;
}

@property (nonatomic, retain) NSString* Name;
@property (nonatomic, retain) NSString* NamespaceURI;
@property (nonatomic, retain) NSString* QualifiedName;
@property (nonatomic, retain) NSDictionary* Attributes;
@property (nonatomic, retain) FTXMLNode* ParentNode;
@property (nonatomic, retain) NSMutableString* Value;
@property (nonatomic, retain) NSMutableArray* Nodes;

- (id) toObject;

@end
