    //
//  RootSearchController.m
//  Marisol
//
//  Created by T.J. Simmons on 5/3/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "RootSearchController.h"
#import "SearchViewController.h"


@implementation RootSearchController

@synthesize navController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
/*- (void)loadView {
	SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName: @"SearchViewController" bundle: nil];
	UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController: searchViewController];
	
	self.navController = navigation;
	[navigation release];
	
	[self.view addSubview: self.navController.view];
	
	[searchViewController release];
}*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName: @"SearchViewController" bundle: nil];
	UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController: searchViewController];
	
	self.navController = navigation;
	[navigation release];
	
	[self.view addSubview: self.navController.view];
	
	[searchViewController release];
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
