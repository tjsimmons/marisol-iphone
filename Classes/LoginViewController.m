//
//  LoginViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "LoginViewController.h"
#import "iStatRootViewController.h"


@implementation LoginViewController

@synthesize usernameField;
@synthesize passwordField;
@synthesize rootViewController;

#pragma mark -
#pragma mark Custom Methods
-(IBAction) loginButtonPressed {
	[self dismissModalViewControllerAnimated: YES];
	
	// tell our iStat controller the login finished
	[self.rootViewController loginViewDidDismiss];
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
}


- (void)dealloc {
	self.usernameField = nil;
	self.passwordField = nil;
	self.rootViewController = nil;
    [super dealloc];
}


@end
