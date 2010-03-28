//
//  MarisolAppDelegate.m
//  Marisol
//
//  Created by T.J. Simmons on 3/27/10.
//  Copyright T.J. Simmons 2010. All rights reserved.
//

#import "MarisolAppDelegate.h"

@implementation MarisolAppDelegate

@synthesize window;
@synthesize tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    // Override point for customization after application launch
	[window addSubview: tabBarController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [window release];
	[tabBarController release];
    [super dealloc];
}


@end
