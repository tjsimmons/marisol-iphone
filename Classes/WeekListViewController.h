//
//  WeekListViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeekListViewController : UITableViewController {
	NSString	*activeStat;
	NSArray		*weekList;
}

@property (nonatomic, retain) NSString *activeStat;
@property (nonatomic, retain) NSArray *weekList;

-(void) setWeekOffset;

@end