//
//  iStatViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 4/6/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "iStatViewController.h"
#import "WeekListViewController.h"


@implementation iStatViewController

@synthesize navController;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// the following line MAGICALLY fixes our cell cutting off problem
	self.view.frame = CGRectMake(0, 20, 320, 480);
	
	WeekListViewController *weekViewController = [[WeekListViewController alloc] initWithStyle: UITableViewStylePlain];
	NSString *weekViewTitle = [[NSString alloc] initWithString: @"iSTAT"];
	
	weekViewController.title = weekViewTitle;
	[weekViewTitle release];
	
	UINavigationController *navCont = [[UINavigationController alloc] initWithRootViewController: weekViewController];
	
	self.navController = navCont;
	[navCont release];
	[weekViewController release];
	
	[self.view addSubview: navController.view];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	self.navController = nil;
}


- (void)dealloc {
	self.navController = nil;
    [super dealloc];
}


@end

