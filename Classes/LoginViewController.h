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
	// IB stuff
	UITextField *usernameField;
	UITextField *passwordField;
	UIButton *loginButton;
	UIActivityIndicatorView *activityIndicator;
	
	// stuff to log in with
	NSMutableData	*theData;
	NSString		*tempFilePath;
	NSURLConnection *connection;
}

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UIButton *loginButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSURLConnection *connection;

-(IBAction) usernameFieldDoneEditing;
-(IBAction) passwordFieldDoneEditing;
-(IBAction) backgroundTap;
-(IBAction) loginButtonPressed;

-(void) initiateLogin;
-(void) loginFinished;

@end
