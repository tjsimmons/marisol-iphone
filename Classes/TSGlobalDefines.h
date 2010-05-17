//
//  TSGlobalDefines.h
//  Marisol
//
//  Created by T.J. Simmons on 5/17/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

// declare a typedef enum to figure out easily what class called the parser
typedef enum { MIHomeVC = 0, MIShipmentVC, MILoginVC } caller;
typedef enum { iStatButton = 0, exStatButton, cancelButton } actionButtonIndex;

#define kUsernameKey		@"username"
#define kCustomerKey		@"customer"
#define kIstatKey			@"istat"
#define kExstatKey			@"exstat"
#define kLoggedInKey		@"loggedIn"

#define iSTAT				@"iSTAT"
#define exSTAT				@"exSTAT"

#define kApplication		[UIApplication sharedApplication]
#define kUserDefaults		[NSUserDefaults standardUserDefaults]
#define kAppDelegateTabBar	[[[[UIApplication sharedApplication] delegate] tabBarController] tabBar]