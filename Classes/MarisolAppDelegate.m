//
//  MarisolAppDelegate.m
//  Marisol
//
//  Created by T.J. Simmons on 3/27/10.
//  Copyright T.J. Simmons 2010. All rights reserved.
//

#import "MarisolAppDelegate.h"
#import "LoginViewController.h"
#import "HomeViewController.h"

@implementation MarisolAppDelegate

@synthesize window;
@synthesize tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
    // Override point for customization after application launch
	UITabBarController *tabController = [[UITabBarController alloc] init];
	NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
	
	HomeViewController *homeController = [[HomeViewController alloc] initWithNibName: @"HomeViewController" bundle: nil];
	
	NSString *homeTitle = [[NSString alloc] initWithString: @"Home"];
	
	homeController.title = homeTitle;
	
	[viewControllers addObject: homeController];
	
	[homeTitle release];
	
	[tabController setViewControllers: viewControllers];
	
	self.tabBarController = tabController;
	
	[tabController release];
	[viewControllers release];
	
	LoginViewController *loginController = [[LoginViewController alloc] initWithNibName: @"LoginViewController" bundle: nil];
	
	[window addSubview: tabBarController.view];
	
	// present the login controller
	[tabBarController presentModalViewController: loginController animated: YES];
	
    [window makeKeyAndVisible];
	
	return YES;
}

-(void) setTabBarControllers: (NSMutableArray *) controllers {
	[self.tabBarController setViewControllers: controllers];
}


- (void)dealloc {
    [window release];
	[tabBarController release];
    [super dealloc];
}


@end
