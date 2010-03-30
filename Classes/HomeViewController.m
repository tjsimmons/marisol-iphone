//
//  HomeViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 3/29/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "HomeViewController.h"
#import "iStatRootViewController.h"
#import "exStatRootViewController.h"

#define kProductsKey	@"products"


@implementation HomeViewController

#pragma mark -
#pragma mark Custom Methods
-(void) setTabBarViewControllers {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithObjects: self, nil];
	
	BOOL iStat = NO;
	BOOL exStat = NO;
	
	if ( [[defaults objectForKey: kProductsKey] isEqualToString: @"iStat"] ) {
		iStat = YES;
	} else if ( [[defaults objectForKey: kProductsKey] isEqualToString: @"exStat"] ) {
		exStat = YES;
	} else if ( [[defaults objectForKey: kProductsKey] isEqualToString: @"iStatexStat"] ) {
		iStat = YES;
		exStat = YES;
	}
	
	NSLog(@"defaults are %@", [defaults objectForKey: kProductsKey]);
	
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
	
	[[[UIApplication sharedApplication] delegate] setTabBarControllers: viewControllers];
	
	[viewControllers release];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self setTabBarViewControllers];
}

- (void)dealloc {
    [super dealloc];
}


@end
