//
//  ChooserViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 5/11/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChooserViewController : UIViewController <UITableViewDelegate> {
	NSArray *customerList;
	UITableView *MItableView;
	NSIndexPath *lastCheckedCell;
}

@property (nonatomic, retain) NSArray *customerList;
@property (nonatomic, retain) IBOutlet UITableView *MItableView;
@property (nonatomic, retain) NSIndexPath *lastCheckedCell;

@end
