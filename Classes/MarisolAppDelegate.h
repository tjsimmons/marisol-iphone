//
//  MarisolAppDelegate.h
//  Marisol
//
//  Created by T.J. Simmons on 4/5/10.
//  Copyright T.J. Simmons 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MarisolAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

-(void) setTabBarControllers: (NSArray *) controllers;

@end

