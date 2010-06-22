//
//  LoginViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "LoginViewController.h"
#import "Reachability.h"
#import "Customer.h"
#import "ChooserViewController.h"


@implementation LoginViewController

@synthesize usernameField;
@synthesize passwordField;
@synthesize loginButton;
@synthesize activityIndicator;
@synthesize connection;
@synthesize parentController;

#pragma mark -
#pragma mark Custom Methods
-(IBAction) usernameFieldDoneEditing {
	[usernameField resignFirstResponder];
	[passwordField becomeFirstResponder];
}

-(IBAction) passwordFieldDoneEditing {	
	[self loginButtonPressed];
}

-(IBAction) backgroundTap {
	[usernameField resignFirstResponder];
	[passwordField resignFirstResponder];
}

-(IBAction) loginButtonPressed {
	NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
	
	if ( [usernameField.text isEqualToString: @""] || [passwordField.text isEqualToString: @""] ) {
		UIAlertView	*alert = [[UIAlertView alloc] initWithTitle: @"Error"
														message: @"Please enter a username and password!"
													   delegate: nil
											  cancelButtonTitle: @"Done" otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
	
	if ( ![passwordField.text isEqualToString: @""] && ![usernameField.text isEqualToString: @""] ) {
		[defaults setObject: usernameField.text forKey: kUsernameKey];
		
		networkAvailability = [[Reachability reachabilityWithHostName: @"www.marisolintl.com"] retain];
		NetworkStatus networkStatus = [networkAvailability currentReachabilityStatus];
		
		if ( networkStatus != NotReachable ) {
			self.loginButton.hidden = YES;
			self.activityIndicator.hidden = NO;
			
			[self initiateLogin];
		} else {
			UIAlertView *alert =  [[UIAlertView alloc] initWithTitle: @"Connection Error"
															 message: @"Unable to connect" delegate: nil cancelButtonTitle: @"Done"
												   otherButtonTitles: nil];
			
			[alert show];
			[alert release];
		}
	}
}

-(void) initiateLogin {
	NSString *url = [[NSString alloc] initWithFormat: @"https://www.marisolintl.com/iphone/loginxml.asp?username=%@&password=%@",
					 usernameField.text, passwordField.text];
	ConnectionHandler *handler = [[ConnectionHandler alloc] initWithDelegate: self];
	
	NSString *component = [[NSString alloc] initWithString: @"login.xml"];
	
	handler.xmlPathComponent = component;
	
	[handler beginURLConnection: url];
	
	[component release];
	[url release];
	[handler release];
}

#pragma mark -
#pragma mark Connection Handler Delegate Methods
-(void) connectionFinishedWithFilePath: (NSString *) filePath {
	XMLParseHandler *handler = [[XMLParseHandler alloc] initWithDelegate: self];
	
	handler.callingClass = MILoginVC;
	
	[handler startXMLParseWithFile: filePath];
	
	[handler release];
}

#pragma mark -
#pragma mark XML Parse Handler Delegate Methods
-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array {
	NSArray *xmlArray = [[NSArray alloc] initWithArray: array];
	if ( [array count] == 1 ) {
		Customer *customer = (Customer *) [xmlArray objectAtIndex: 0];
		
		if ( [[customer customerName] isEqualToString: @"nologin"] ) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error"
															message: @"Incorrect login"
														   delegate: nil
												  cancelButtonTitle: @"Okay" otherButtonTitles: nil];
			[alert performSelectorOnMainThread: @selector(show) withObject: nil waitUntilDone: NO];
			
			[alert release];
			
			self.loginButton.hidden = NO;
			self.activityIndicator.hidden = YES;			
		} else {
			[kUserDefaults setObject: customer.customerName forKey: kCustomerKey];
			[kUserDefaults setObject: customer.iStat forKey: kIstatKey];
			[kUserDefaults setObject: customer.exStat forKey: kExstatKey];
			[kUserDefaults setBool: YES forKey: kLoggedInKey];
			
			[self dismissModalViewControllerAnimated: YES];
		}
	} else {
		[self.parentController setCustomerList: xmlArray];
		[self dismissModalViewControllerAnimated: YES];
	}
	
	[xmlArray release];
}

#pragma mark -
#pragma mark View Methods

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	self.usernameField.text = [defaults objectForKey: kUsernameKey];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.usernameField = nil;
	self.passwordField = nil;
	self.activityIndicator = nil;
	self.loginButton = nil;
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];

	self.loginButton.hidden = NO;
	self.activityIndicator.hidden = YES;
}

-(void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if ( [kUserDefaults boolForKey: kLoggedInKey] ) {
		[self dismissModalViewControllerAnimated: YES];
	}
}


- (void)dealloc {
	self.usernameField = nil;
	self.passwordField = nil;
	self.activityIndicator = nil;
	self.loginButton = nil;
	
	[networkAvailability release];
    [super dealloc];
}


@end