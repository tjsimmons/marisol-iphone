//
//  StatViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 5/17/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeekListViewController;

@interface StatViewController : UIViewController <UIActionSheetDelegate> {
	UINavigationController *navController;
	NSString	*activeStat;
	WeekListViewController *childController;
}

@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) NSString *activeStat;
@property (nonatomic, retain) WeekListViewController *childController;

-(void) changeActiveProduct;

@end
