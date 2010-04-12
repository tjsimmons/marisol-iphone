//
//  HomeXMLParseHandler.h
//  Marisol
//
//  Created by T.J. Simmons on 4/12/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeXMLParseHandlerDelegate;

@class HomeCellModel;

@interface HomeXMLParseHandler : NSObject {
	id <HomeXMLParseHandlerDelegate> delegate;
	
	// stuff used during parsing
	
	HomeCellModel	*currentObject;
	NSMutableArray	*objectList;
	NSMutableString *currentParsedCharacterData;
	NSUInteger		parsedObjectCounter;
	BOOL			accumulatingCharacterData;
}

@property (nonatomic, assign) id <HomeXMLParseHandlerDelegate> delegate;

@property (nonatomic, retain) HomeCellModel *currentObject;
@property (nonatomic, retain) NSMutableArray *objectList;
@property (nonatomic, retain) NSMutableString *currentParsedCharacterData;

-(id) initWithDelegate: (id) del;
-(void) startXMLParseWithFile: (NSString *) xmlFile;
-(void) addObjectsToList: (NSArray *) articles;
-(void) parseXMLData: (NSString *) xmlFile;

@end

@protocol HomeXMLParseHandlerDelegate

-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array;

@end