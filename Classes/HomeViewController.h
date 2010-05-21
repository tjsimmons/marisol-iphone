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


@interface HomeViewController : UIViewController <ConnectionHandlerDelegate, XMLParseHandlerDelegate, UITableViewDataSource, UITableViewDelegate> {
	NSArray *customerList;
	NSArray *cellInformation;
	
	BOOL dataLoaded;
	
	UITableView *infoTableView;
	
	// cells for the home screen
	UITableViewCell *firstCell;
	UITableViewCell *secondCell;
	UITableViewCell *thirdCell;
	UITableViewCell *fourthCell;
}

@property (nonatomic, retain) NSArray *customerList;
@property (nonatomic, retain) NSArray *cellInformation;

@property (nonatomic, retain) IBOutlet UITableView *infoTableView;

@property (nonatomic, retain) IBOutlet UITableViewCell *firstCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *secondCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *thirdCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *fourthCell;

-(void) setCellValues;//WithArray: (NSArray *) array;
-(void) startConnectionForCellData;
-(void) showChooser;

// connection handler delegate method
-(void) connectionFinishedWithFilePath: (NSString *) filePath;

// home xml parse handler delegate method
-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array;

@end
