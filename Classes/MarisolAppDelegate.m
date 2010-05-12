//
//  MarisolAppDelegate.m
//  Marisol
//
//  Created by T.J. Simmons on 4/5/10.
//  Copyright T.J. Simmons 2010. All rights reserved.
//

#import "MarisolAppDelegate.h"
//#import "LoginViewController.h"
#import "HomeViewController.h"

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
	
	NSArray *array = [[NSArray alloc] initWithObjects: homeController, nil];
	
	[tabController setViewControllers: array];
	[array release];
	[homeController release];
	
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

#pragma mark -
#pragma mark Custom Methods
-(void) setTabBarControllers: (NSMutableArray *) controllers {
	[self.tabBarController setViewControllers: controllers];
}

@end