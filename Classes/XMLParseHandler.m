//
//  XMLParseHandler.m
//  
//
//  Created by T.J. Simmons on 3/25/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "XMLParseHandler.h"
#import "Shipment.h"
#import "HomeCellModel.h"

// Shipment List Constants
#define kShipmentElementName			@"shipment"
#define kMarisolNumElementName			@"marisolNum"
#define kDeliveryDateElementName		@"deliveryDate"
#define kColdStorageDateElementName		@"coldStorageDate"

// Home Constants
#define	kCellElementName			@"cell"
#define kTitleElementName			@"title"

@implementation XMLParseHandler

@synthesize delegate;

@synthesize callingClass;

@synthesize currentObject;
@synthesize objectList;
@synthesize currentParsedCharacterData;


#pragma mark -
#pragma mark Custom Methods
-(id) initWithDelegate:(id)del {
	if ( self == [super init] ) {
		self.delegate = del;
	}
	
	return self;
}

-(void) startXMLParseWithFile: (NSString *) xmlFile {
	NSMutableArray *mutableObjectArray = [[NSMutableArray alloc] init];
	
	self.objectList = mutableObjectArray;
	
	[mutableObjectArray release];
	
	[NSThread detachNewThreadSelector: @selector(parseXMLData:) toTarget: self withObject: xmlFile];
}

-(void) addObjectsToList: (NSArray *) objects {
	[self.objectList addObjectsFromArray: objects];
}

-(void) parseXMLData: (NSString *) xmlFile {
	// per Apple's instructions, must create an autorelease pool for each secondary thread
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL: [NSURL fileURLWithPath: xmlFile]];
	
	[parser setDelegate: self];
	[parser parse];
	
	
	self.currentParsedCharacterData = nil;
	self.currentObject = nil;
	
	[parser release];
	[pool release];
}

#pragma mark -
#pragma mark NSXMLParser Delegate Methods
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	if ( callingClass == MIShipmentVC ) {
		if ( [elementName isEqualToString: kShipmentElementName] ) {
			Shipment *shipment = [[Shipment alloc] init];
			
			self.currentObject = shipment;
			[shipment release];
			
			[currentObject setShipmentID: [[attributeDict objectForKey: @"id"] integerValue]];
		} else if ( [elementName isEqualToString: kMarisolNumElementName] || [elementName isEqualToString: kDeliveryDateElementName] || [elementName isEqualToString: kColdStorageDateElementName] ) {
			accumulatingCharacterData = YES;
			
			self.currentParsedCharacterData = [NSMutableString string];
			
			[self.currentParsedCharacterData setString: @""];
		}
	} else if ( callingClass == MIHomeVC ) {
		if ( [elementName isEqualToString: kCellElementName] ) {
			HomeCellModel *cellModel = [[HomeCellModel alloc] init];
			
			self.currentObject = cellModel;
			[cellModel release];
			
			[currentObject setCellIndex: [[attributeDict objectForKey: @"index"] integerValue]];
		} else if ( [elementName isEqualToString: kTitleElementName] ) {
			[currentObject setCellValue: [attributeDict objectForKey: @"value"]];
			
			accumulatingCharacterData = YES;
			
			self.currentParsedCharacterData = [NSMutableString string];
			
			[self.currentParsedCharacterData setString: @""];
		}
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ( callingClass == MIShipmentVC ) {
		if ( [elementName isEqualToString: kMarisolNumElementName] ) {
			[currentObject setMarisolNum: self.currentParsedCharacterData];
			
			self.currentParsedCharacterData = nil;
		} else if ( [elementName isEqualToString: kDeliveryDateElementName] ) {
			[currentObject setDeliveryDateString: self.currentParsedCharacterData];
			
			self.currentParsedCharacterData = nil;
		} else if ( [elementName isEqualToString: kColdStorageDateElementName] ) {
			[currentObject setColdStorageDateString: self.currentParsedCharacterData];
			
			self.currentParsedCharacterData = nil;
		} else if ( [elementName isEqualToString: kShipmentElementName] ) {
			[self.objectList addObject: currentObject];
			
			self.currentObject = nil;
		}
	} else if ( callingClass == MIHomeVC ) {
		if ( [elementName isEqualToString: kTitleElementName] ) {
			[currentObject setCellTitle: self.currentParsedCharacterData];
			
			self.currentParsedCharacterData = nil;
		} else if ( [elementName isEqualToString: kCellElementName] ) {
			[self.objectList addObject: currentObject];
			
			self.currentObject = nil;
		}
	}
	
	accumulatingCharacterData = NO;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if ( accumulatingCharacterData ) {
		[currentParsedCharacterData appendString: string];
	}
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	// override
	NSLog(@"Parse Error Occured: Error is %@", [parseError description]);
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	[delegate xmlDidFinishParsingWithArray: self.objectList];
}

#pragma mark -
#pragma mark Memory Management
-(void) dealloc {
	// by using the setter properties (if set to retain), setting to nil releases then sets object to nil. much safer.
	self.objectList = nil;
	self.currentParsedCharacterData = nil;
	
	[super dealloc];
}

@end