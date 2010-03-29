//
//  ShipmentListViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionHandler.h"
#import "XMLParseHandler.h"


@interface ShipmentListViewController : UITableViewController <ConnectionHandlerDelegate, XMLParseHandlerDelegate> {
	NSString			*whichStat;
	NSMutableArray		*shipmentList;
	BOOL				dataLoaded;
}

@property (nonatomic, retain) NSString *whichStat;
@property (nonatomic, retain) NSMutableArray *shipmentList;

-(void) startConnectionProcess;

// Connection Handler Delegate Method
-(void) connectionFinishedWithFilePath:(NSString *)filePath;

// XML Parse Handler Delegate Method
-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array;

@end
