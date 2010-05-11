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

#define kUsernameKey	@"username"
#define kCustomerKey	@"customer"
#define kProductsKey	@"products"
#define kIstatKey		@"istat"
#define kExstatKey		@"exstat"

#define kApplication	[UIApplication sharedApplication]
#define kUserDefaults	[NSUserDefaults standardUserDefaults]

#define MILoginVC		2


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
	
	handler.xmlPathComponent = @"login.xml";
	
	[handler beginURLConnection: url];
	
	[url release];
	[handler release];
}

-(void) loginFinished {
	kApplication.networkActivityIndicatorVisible = NO;
	
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
		
		// figure out customer name, iSTAT and exSTAT access
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
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
		[defaults setObject: customer forKey: kCustomerKey];
		[defaults setObject: products forKey: kProductsKey];
		
		[scanner release];
		
		[self dismissModalViewControllerAnimated: YES];
	}
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
	if ( [array count] == 1 ) {
		Customer *customer = (Customer *) [array objectAtIndex: 0];
		
		[kUserDefaults setObject: customer.customerName forKey: kCustomerKey];
		[kUserDefaults setObject: customer.iStat forKey: kIstatKey];
		[kUserDefaults setObject: customer.exStat forKey: kExstatKey];
	}

	[self dismissModalViewControllerAnimated: YES];
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

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"%@", error);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error"
													message: @"There was an error. Please try again."
												   delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
	[alert show];
	[alert release];
	
	self.activityIndicator.hidden = YES;
	self.loginButton.hidden = NO;
	kApplication.networkActivityIndicatorVisible = NO;
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


- (void)dealloc {
	self.usernameField = nil;
	self.passwordField = nil;
	self.activityIndicator = nil;
	self.loginButton = nil;
	
	[networkAvailability release];
    [super dealloc];
}


@end