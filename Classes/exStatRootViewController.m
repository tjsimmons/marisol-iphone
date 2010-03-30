//
//  exStatRootViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "exStatRootViewController.h"
#import "WeekListViewController.h"


@implementation exStatRootViewController

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	WeekListViewController *weekController = [[WeekListViewController alloc] initWithNibName: @"WeekListViewController" bundle: nil];
	
	weekController.title = @"exSTAT Week List";
	weekController.whichStat = @"exSTAT";
	
	[self.navController pushViewController: weekController animated: NO];
	[self.view addSubview: navController.view];
	
	[weekController release];
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
