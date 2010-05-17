//
//  XMLParseHandler.h
//  
//
//  Created by T.J. Simmons on 3/25/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//
//	Uncomment everything for currentObject with the correct object class to set the class up properly

#import <Foundation/Foundation.h>
#import "TSGlobalDefines.h"

@class Shipment;

@protocol XMLParseHandlerDelegate;

// make this a little more "copy" friendly for OS 4.0, which requires the NSXMLParserDelegate protocol to be declared as implemented
#ifndef __IPHONE_4_0
@interface XMLParseHandler : NSObject
#else
@interface XMLParseHandler : NSObject <NSXMLParserDelegate>
#endif

{
	id <XMLParseHandlerDelegate> delegate;
	
	// what class called the parser, so we know what elements to parse
	caller			callingClass;
	
	// stuff used during parsing
	
	id				currentObject;
	NSMutableArray	*objectList;
	NSMutableString *currentParsedCharacterData;
	NSUInteger		parsedObjectCounter;
	BOOL			accumulatingCharacterData;
}

@property (nonatomic, assign) id <XMLParseHandlerDelegate> delegate;

@property caller callingClass;

@property (nonatomic, retain) id currentObject;
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