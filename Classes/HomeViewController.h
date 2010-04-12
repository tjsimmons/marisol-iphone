//
//  HomeViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 4/6/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionHandler.h"
#import "HomeXMLParseHandler.h"


@interface HomeViewController : UIViewController <ConnectionHandlerDelegate, HomeXMLParseHandlerDelegate> {
	BOOL pastInitialLogin;
	NSMutableArray *cells;
}

@property (nonatomic, retain) NSMutableArray *cells;

-(void) setTabBarViewControllers;
-(void) setCellValuesWithArray: (NSArray *) array;
-(void) startConnectionForCellData;

// connection handler delegate method
-(void) connectionFinishedWithFilePath: (NSString *) filePath;

// home xml parse handler delegate method
-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array;

@end
