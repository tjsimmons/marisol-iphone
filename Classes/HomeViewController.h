//
//  HomeViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 4/6/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController {
	BOOL pastInitialLogin;
	NSMutableArray *cells;
}

@property (nonatomic, retain) NSMutableArray *cells;

-(void) setTabBarViewControllers;
-(void) setCellValues;
-(void) handleConnectionAndXMLForCellAtRow: (NSNumber *) row;

@end
