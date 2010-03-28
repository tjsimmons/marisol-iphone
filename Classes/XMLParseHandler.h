//
//  XMLParseHandler.h
//  
//
//  Created by T.J. Simmons on 3/25/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//
//	Uncomment everything for currentObject with the correct object class to set the class up properly

#import <Foundation/Foundation.h>

@class Shipment;

@protocol XMLParseHandlerDelegate;

@interface XMLParseHandler : NSObject {
	id <XMLParseHandlerDelegate> delegate;
	
	// stuff used during parsing
	
	Shipment		*currentObject;
	NSMutableArray	*objectList;
	NSMutableString *currentParsedCharacterData;
	NSUInteger		parsedObjectCounter;
	BOOL			accumulatingCharacterData;
}

@property (nonatomic, assign) id <XMLParseHandlerDelegate> delegate;

@property (nonatomic, retain) Shipment *currentObject;
@property (nonatomic, retain) NSMutableArray *objectList;
@property (nonatomic, retain) NSMutableString *currentParsedCharacterData;

-(id) initWithDelegate: (id) del;
-(void) startXMLParseWithFile: (NSString *) xmlFile;
-(void) addObjectsToList: (NSArray *) articles;
-(void) parseXMLData: (NSString *) xmlFile;

@end

@protocol XMLParseHandlerDelegate

-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array;

@end