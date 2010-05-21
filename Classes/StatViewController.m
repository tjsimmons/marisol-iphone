    //
//  StatViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 5/17/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "StatViewController.h"
#import "WeekListViewController.h"


@implementation StatViewController

@synthesize navController;
@synthesize activeStat;
@synthesize childController;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// the following line MAGICALLY fixes our cell cutting off problem
	self.view.frame = CGRectMake(0, 20, 320, 480);
	
	WeekListViewController *weekViewController = [[WeekListViewController alloc] initWithStyle: UITableViewStylePlain];
	
	self.childController = weekViewController;
	
	[weekViewController release];
	
	NSMutableString	*weekViewTitle = [[NSMutableString alloc] init];
	
	if ( [[kUserDefaults objectForKey: kIstatKey] isEqualToString: @"yes"] && [[kUserDefaults objectForKey: kExstatKey] isEqualToString: @"yes"] ) {
		NSString *buttonTitle = [[NSString alloc] initWithString: @"Change"];
		UIBarButtonItem *productButton = [[UIBarButtonItem alloc] initWithTitle: buttonTitle style: UIBarButtonItemStyleBordered 
																		 target: self action: @selector(changeActiveProduct)];
		
		self.childController.navigationItem.rightBarButtonItem = productButton;
		
		[buttonTitle release];
		[productButton release];
		
		[self changeActiveProduct];
	} else {
		if ( [[kUserDefaults objectForKey: kIstatKey] isEqualToString: @"yes"] ) {
			self.activeStat = iSTAT;
			self.childController.activeStat = iSTAT;
			[weekViewTitle setString: iSTAT];
		} else if ( [[kUserDefaults objectForKey: kExstatKey] isEqualToString: @"yes"] ) {
			self.activeStat = exSTAT;
			self.childController.activeStat = exSTAT;
			[weekViewTitle setString: exSTAT];
		}
	}
	
	childController.title = weekViewTitle;
	[weekViewTitle release];
	
	UINavigationController *navCont = [[UINavigationController alloc] initWithRootViewController: weekViewController];
	navCont.delegate = self;
	
	self.navController = navCont;
	[navCont release];
	
	[self.view addSubview: navController.view];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}
#pragma mark -
#pragma mark Custom Methods
-(void) changeActiveProduct {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: @"Please select a product:" delegate: self cancelButtonTitle: @"Cancel" 
											   destructiveButtonTitle: nil otherButtonTitles: @"iSTAT", @"exSTAT", nil];
	
	[actionSheet showFromTabBar: kAppDelegateTabBar];
	[actionSheet release];
}

#pragma mark -
#pragma mark UIActionSheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	NSMutableString *weekTitle = [[NSMutableString alloc] init];
	switch ( buttonIndex ) {
		case cancelButton:
			if ( !self.activeStat ) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert"
																message: @"Please choose a product"
															   delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
				[alert show];
				[alert release];
			}
			break;
		case iStatButton:
			self.activeStat = iSTAT;
			self.childController.activeStat = iSTAT;
			[weekTitle setString: iSTAT];
			self.childController.title = weekTitle;
			[self.childController setWeekOffset];
			break;
		case exStatButton:
			self.activeStat = exSTAT;
			self.childController.activeStat = exSTAT;
			[weekTitle setString: exSTAT];
			self.childController.title = weekTitle;
			[self.childController setWeekOffset];
			break;
	}
	
	[weekTitle release];
}

#pragma mark -
#pragma mark UINavigationController Delegate Methods
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	/* hold in case we want to use it at some point */
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	if ( [viewController.title isEqualToString: @"Shipment Details"] ) {
		kAppDelegateTabBar.hidden = YES;
	} else {
		kAppDelegateTabBar.hidden = NO;
	}
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
	self.activeStat = nil;
	self.childController = nil;
}


- (void)dealloc {
	self.navController = nil;
	self.activeStat = nil;
	self.childController = nil;
	
    [super dealloc];
}


@end
