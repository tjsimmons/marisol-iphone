//
//  MarisolAppDelegate.m
//  Marisol
//
//  Created by T.J. Simmons on 4/5/10.
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
	LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName: @"LoginViewController" bundle: nil];
	HomeViewController *homeController = [[HomeViewController alloc] initWithNibName: @"HomeViewController" bundle: nil];
	NSString *homeTitle = [[NSString alloc] initWithString: @"Home"];
	
	homeController.title = homeTitle;
	[homeTitle release];
	
	NSArray *array = [[NSArray alloc] initWithObjects: homeController, nil];
	
	[tabController setViewControllers: array];
	[array release];
	[homeController release];
	
	self.tabBarController = tabController;
	
	[tabController release];
	
	[window addSubview: tabBarController.view];
	[tabBarController presentModalViewController: loginViewController animated: YES];
	[loginViewController release];
	
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
	[tabBarController release];
    [window release];
    [super dealloc];
}

#pragma mark -
#pragma mark Custom Methods
-(void) setTabBarControllers: (NSArray *) controllers {
	[self.tabBarController setViewControllers: controllers];
}

@end
