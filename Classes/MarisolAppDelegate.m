//
//  MarisolAppDelegate.m
//  Marisol
//
//  Created by T.J. Simmons on 3/27/10.
//  Copyright T.J. Simmons 2010. All rights reserved.
//

#import "MarisolAppDelegate.h"
#import "LoginViewController.h"
#import "iStatRootViewController.h"
#import "exStatRootViewController.h"

@implementation MarisolAppDelegate

@synthesize window;
@synthesize tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	BOOL iStat = YES;
	BOOL exStat = YES;
	
    // Override point for customization after application launch
	UITabBarController *tabController = [[UITabBarController alloc] init];
	NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
	
	if ( iStat ) {
		iStatRootViewController *iStatController = [[iStatRootViewController alloc] initWithNibName: @"iStatRootViewController" bundle: nil];
		
		NSString *viewTitle = [[NSString alloc] initWithString: @"iSTAT"];
		
		iStatController.title = viewTitle;
		
		[viewControllers addObject: iStatController];
		[iStatController release];
		[viewTitle release];
	}
	
	if ( exStat ) {
		exStatRootViewController *exStatController = [[exStatRootViewController alloc] initWithNibName: @"exStatRootViewController" bundle: nil];
		
		NSString *viewTitle = [[NSString alloc] initWithString: @"exSTAT"];
		
		exStatController.title = viewTitle;
		
		[viewControllers addObject: exStatController];
		[exStatController release];
		[viewTitle release];
	}
	
	[tabController setViewControllers: viewControllers];
	
	self.tabBarController = tabController;
	
	[tabController release];
	
	LoginViewController *loginController = [[LoginViewController alloc] initWithNibName: @"LoginViewController" bundle: nil];
	
	[window addSubview: tabBarController.view];
	
	// present the login controller
	[tabBarController presentModalViewController: loginController animated: YES];
	
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [window release];
	[tabBarController release];
    [super dealloc];
}


@end
