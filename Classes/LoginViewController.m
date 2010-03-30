//
//  LoginViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "LoginViewController.h"
#import "iStatRootViewController.h"

#define kUsernameKey	@"username"


@implementation LoginViewController

@synthesize usernameField;
@synthesize passwordField;
@synthesize loginButton;
@synthesize activityIndicator;
@synthesize connection;

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
		
		self.loginButton.hidden = YES;
		self.activityIndicator.hidden = NO;
		
		[self initiateLogin];
	}
}

-(void) initiateLogin {
	if ( connection == nil ) {
		NSString *loginURLString = [NSString stringWithFormat: @"https://www.marisolintl.com/iphone/login.asp?username=%@&password=%@", usernameField.text, passwordField.text];
		NSURL *loginURL = [NSURL URLWithString: loginURLString];
		NSURLRequest *loginRequest = [NSURLRequest requestWithURL: loginURL
													  cachePolicy: NSURLRequestUseProtocolCachePolicy
												  timeoutInterval: 10.0];
		connection = [[NSURLConnection alloc] initWithRequest: loginRequest
													 delegate: self];
		
		if ( connection ) {
			[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
			theData = [[NSMutableData data] retain];
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Unable to connect"
															message: @"There is an error."
														   delegate: nil
												  cancelButtonTitle: @"Okay" otherButtonTitles: nil];
			[alert show];
			[alert release];
			
			[self.connection cancel];
			self.connection = nil;
		}
	}
}

-(void) loginFinished {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	NSString *initialData = [NSString stringWithContentsOfFile: tempFilePath 
													  encoding: NSUTF8StringEncoding error: nil];
	
	NSCharacterSet *trimSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	
	NSString *loginData = [initialData stringByTrimmingCharactersInSet: trimSet];
	
	if ( [loginData isEqualToString: @"0"] ) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error"
														message: @"Incorrect login"
													   delegate: nil
											  cancelButtonTitle: @"Okay" otherButtonTitles: nil];
		[alert show];
		[alert release];
		[passwordField becomeFirstResponder];
		
		[connection cancel];
		self.connection = nil;
		
		// revert activity indicator and login button
		self.activityIndicator.hidden = YES;
		self.loginButton.hidden = NO;
	} else {
		[usernameField resignFirstResponder];
		[passwordField resignFirstResponder];
		
		// need to do more here with iSTAT, exSTAT access
		NSScanner *scanner = [[NSScanner alloc] initWithString: loginData];
		NSString *customer = nil;
		NSString *products = nil;
		
		// scan customer into customer string
		[scanner scanUpToString: @"?" intoString: &customer];
		
		// ignore the ? and scan past
		[scanner scanString: @"?" intoString: NULL];
		
		// scan the product string
		[scanner scanUpToString: @"!" intoString: &products];

		// set user defaults to access later
		[[NSUserDefaults standardUserDefaults] setObject: customer forKey: @"customer"];
		[[NSUserDefaults standardUserDefaults] setObject: products forKey: @"products"];
		
		[scanner release];
		
		[self dismissModalViewControllerAnimated: YES];
	}
}

#pragma mark -
#pragma mark NSURLConnection Delegate Methods
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[theData setLength: 0];
};

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[theData appendData: data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	tempFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent: @"temp.txt"];
	
	[theData writeToFile: tempFilePath atomically: YES];
	
	[self loginFinished];
	
	[self.connection cancel];
	[self.connection release];
	[theData release];
}

#pragma mark -
#pragma mark View Methods

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.usernameField.text = [[NSUserDefaults standardUserDefaults] objectForKey: kUsernameKey];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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


- (void)dealloc {
	self.usernameField = nil;
	self.passwordField = nil;
	self.activityIndicator = nil;
	self.loginButton = nil;
    [super dealloc];
}


@end
