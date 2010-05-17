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
#import "StatViewController.h"
#import "RootSearchController.h"

#define kCustomerKey	@"customer"
#define kIstatKey		@"istat"
#define kExstatKey		@"exstat"
#define kLoggedInKey	@"loggedIn"

#define kUserDefaults	[NSUserDefaults standardUserDefaults]

@implementation MarisolAppDelegate

@synthesize window;
@synthesize tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    // Override point for customization after application launch
	UITabBarController *tabController = [[UITabBarController alloc] init];
	//LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName: @"LoginViewController" bundle: nil];
	HomeViewController *homeController = [[HomeViewController alloc] initWithNibName: @"HomeViewController" bundle: nil];
	NSString *homeTitle = [[NSString alloc] initWithString: @"Home"];
	UITabBarItem *homeTabBarItem = [[UITabBarItem alloc] initWithTitle: homeTitle image: nil tag: 0];
	
	homeController.tabBarItem = homeTabBarItem;
	
	[homeTabBarItem release];
	
	[homeTitle release];
	
	RootSearchController *searchController = [[RootSearchController alloc] initWithNibName: @"RootSearchController" bundle: nil];
	UITabBarItem *searchTabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem: UITabBarSystemItemSearch tag: 3];
	
	searchController.tabBarItem = searchTabBarItem;
	
	[searchTabBarItem release];
	
	StatViewController *statController = [[StatViewController alloc] init];
	NSString *statTabTitle = [[NSString alloc] initWithString: @"Shipments"];
	UITabBarItem *statTabBarItem = [[UITabBarItem alloc] initWithTitle: statTabTitle image: nil tag: 1];
	
	statController.tabBarItem = statTabBarItem;
	
	[statTabTitle release];
	[statTabBarItem release];
	
	NSArray *array = [[NSArray alloc] initWithObjects: homeController, statController, searchController, nil];
	
	[tabController setViewControllers: array];
	[array release];
	[homeController release];
	[searchController release];
	[statController release];
	
	self.tabBarController = tabController;
	
	[tabController release];
	
	//loginViewController.homeController = [[self.tabBarController viewControllers] objectAtIndex: 0];
	
	[window addSubview: tabBarController.view];
	
	//[tabBarController presentModalViewController: loginViewController animated: YES];
	
	//[loginViewController release];
	
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[kUserDefaults setObject: nil forKey: kCustomerKey];
	[kUserDefaults setObject: nil forKey: kIstatKey];
	[kUserDefaults setObject: nil forKey: kExstatKey];
	[kUserDefaults setBool: NO forKey: kLoggedInKey];
}

- (void)dealloc {
	[tabBarController release];
    [window release];
    [super dealloc];
}

@end