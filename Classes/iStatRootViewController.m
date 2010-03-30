//
//  iStatRootViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "iStatRootViewController.h"
#import "WeekListViewController.h"
#import "LoginViewController.h"


@implementation iStatRootViewController

@synthesize navController;

#pragma mark -
#pragma mark Custom Methods
-(void) loginViewDidDismiss {
	
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
	
	WeekListViewController *weekViewController = [[WeekListViewController alloc] initWithNibName: @"WeekListViewController" bundle: nil];
	
	weekViewController.title = @"iSTAT Week List";
	weekViewController.whichStat = @"iSTAT";
		
	// add in the iSTAT view
	[self.navController pushViewController: weekViewController animated: NO];
	[self.view addSubview: self.navController.view];
	
	[weekViewController release];
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
	self.navController = nil;
}


- (void)dealloc {
	self.navController = nil;
    [super dealloc];
}


@end
