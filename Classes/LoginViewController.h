//
//  LoginViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iStatRootViewController;

@interface LoginViewController : UIViewController {
	UITextField *usernameField;
	UITextField *passwordField;
	
	iStatRootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) iStatRootViewController *rootViewController;

-(IBAction) loginButtonPressed;

@end
