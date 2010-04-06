//
//  MarisolAppDelegate.m
//  Marisol
//
//  Created by T.J. Simmons on 4/5/10.
//  Copyright T.J. Simmons 2010. All rights reserved.
//

#import "MarisolAppDelegate.h"

@implementation MarisolAppDelegate

@synthesize window;
@synthesize tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    // Override point for customization after application launch
	
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
