//
//  iStatRootViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iStatRootViewController : UIViewController {
	UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navController;

-(void) loginViewDidDismiss;

@end
