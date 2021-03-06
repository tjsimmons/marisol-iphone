//
//  TSGlobalDefines.h
//  Marisol
//
//  Created by T.J. Simmons on 5/17/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

// set a typedef to figure out what class called the parser
typedef enum { MIHomeVC = 0, MIiShipmentVC, MIeShipmentVC, MILoginVC } caller;

// index of the action sheet button in search and stat controllers
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