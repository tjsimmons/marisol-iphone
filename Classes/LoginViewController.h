//
//  LoginViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSGlobalDefines.h"
#import "ConnectionHandler.h"
#import "XMLParseHandler.h"

@class Reachability;

@interface LoginViewController : UIViewController <ConnectionHandlerDelegate, XMLParseHandlerDelegate> {
	// IB stuff
	UITextField					*usernameField;
	UITextField					*passwordField;
	UIButton					*loginButton;
	UIActivityIndicatorView		*activityIndicator;
	
	// stuff to log in with
	NSMutableData	*theData;
	NSString		*tempFilePath;
	NSURLConnection *connection;
	
	// check for network availability
	Reachability *networkAvailability;
	
	id parentController;
}

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UIButton *loginButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, assign) id parentController;

-(IBAction) usernameFieldDoneEditing;
-(IBAction) passwordFieldDoneEditing;
-(IBAction) backgroundTap;
-(IBAction) loginButtonPressed;

-(void) initiateLogin;

// connection handler delegate
-(void) connectionFinishedWithFilePath: (NSString *) filePath;

// xml parse handler delegate
-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array;

@end
