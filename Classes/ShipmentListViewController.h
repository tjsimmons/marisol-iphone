//
//  ShipmentListViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSGlobalDefines.h"
#import "ConnectionHandler.h"
#import "XMLParseHandler.h"


@interface ShipmentListViewController : UITableViewController <ConnectionHandlerDelegate, XMLParseHandlerDelegate> {
	NSString			*activeStat;
	NSMutableArray		*shipmentList;
	NSString			*startDate;
	NSString			*endDate;
	BOOL				dataLoaded;
}

@property (nonatomic, retain) NSString *activeStat;
@property (nonatomic, retain) NSMutableArray *shipmentList;
@property (nonatomic, retain) NSString *startDate;
@property (nonatomic, retain) NSString *endDate;

-(void) startConnectionProcess;

// Connection Handler Delegate Method
-(void) connectionFinishedWithFilePath:(NSString *)filePath;

// XML Parse Handler Delegate Method
-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array;

@end
