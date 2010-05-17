//
//  HomeViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 4/6/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSGlobalDefines.h"
#import "ConnectionHandler.h"
#import "XMLParseHandler.h"


@interface HomeViewController : UIViewController <ConnectionHandlerDelegate, XMLParseHandlerDelegate> {
	BOOL cellsLoaded;
	NSMutableArray *cells;
}

@property (nonatomic, retain) NSMutableArray *cells;

-(void) setCellValuesWithArray: (NSArray *) array;
-(void) startConnectionForCellData;
-(void) addCellsToHomeScreen;

// connection handler delegate method
-(void) connectionFinishedWithFilePath: (NSString *) filePath;

// home xml parse handler delegate method
-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array;

@end
