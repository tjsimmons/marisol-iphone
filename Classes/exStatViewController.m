    //
//  exStatViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 4/6/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "exStatViewController.h"
#import "WeekListViewController.h"


@implementation exStatViewController

@synthesize navController;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// the following line MAGICALLY fixes our cell cutting off problem
	self.view.frame = CGRectMake(0, 20, 320, 480);
	
	WeekListViewController *weekViewController = [[WeekListViewController alloc] initWithStyle: UITableViewStylePlain];
	NSString *weekViewTitle = [[NSString alloc] initWithString: @"exSTAT"];
	
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