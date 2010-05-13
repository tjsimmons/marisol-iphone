//
//  HomeViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 4/6/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "HomeViewController.h"
#import "iStatViewController.h"
#import "exStatViewController.h"
#import "RootSearchController.h"
#import "HomeCellViewController.h"
#import "HomeCellModel.h"
#import "LoginViewController.h"

#define kCustomerKey		@"customer"
#define kLoggedInKey		@"loggedIn"
#define kIstatKey			@"istat"
#define kExstatKey			@"exstat"

#define kNumCells			4

#define kAppDelegate		[[UIApplication sharedApplication] delegate]
#define kUserDefaults		[NSUserDefaults standardUserDefaults]

#define MIHomeVC			0


@implementation HomeViewController

@synthesize cells;

#pragma mark -
#pragma mark Custom Methods
-(void) setTabBarViewControllers {
	NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithObjects: self, nil];
	
	if ( [[kUserDefaults objectForKey: kIstatKey] isEqualToString: @"yes"] ) {
		iStatViewController *iStatController = [[iStatViewController alloc] init];
		NSString *iTitle = [[NSString alloc] initWithString: @"iSTAT"];
		UITabBarItem *iTabBarItem = [[UITabBarItem alloc] initWithTitle: iTitle image: nil tag: 1];
		
		iStatController.tabBarItem = iTabBarItem;
		
		[viewControllers addObject: iStatController];
		[iStatController release];
		[iTabBarItem release];
		[iTitle release];
	}
	
	if ( [[kUserDefaults objectForKey: kExstatKey] isEqualToString: @"yes"] ) {
		exStatViewController *exStatController = [[exStatViewController alloc] init];
		NSString *exTitle = [[NSString alloc] initWithString: @"exSTAT"];
		UITabBarItem *exTabBarItem = [[UITabBarItem alloc] initWithTitle: exTitle image: nil tag: 2];
		
		exStatController.title = exTitle;
		exStatController.tabBarItem = exTabBarItem;
		
		[viewControllers addObject: exStatController];
		[exStatController release];
		[exTabBarItem release];
		[exTitle release];
	}
	
	// set up the search tab
	RootSearchController *searchController = [[RootSearchController alloc] initWithNibName: @"RootSearchController" bundle: nil];
	UITabBarItem *searchTabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem: UITabBarSystemItemSearch tag: 3];
	
	searchController.tabBarItem = searchTabBarItem;
	
	[viewControllers addObject: searchController];
	[searchController release];
	[searchTabBarItem release];

	[kAppDelegate setTabBarControllers: viewControllers];

	[viewControllers release];
}

-(void) setCellValuesWithArray: (NSArray *) array {
	for ( int i = 0; i < [array count]; i++ ) {
		HomeCellViewController *cell = (HomeCellViewController *) [self.cells objectAtIndex: i];
		HomeCellModel *cellModel = (HomeCellModel *) [array objectAtIndex: i];
		
		[cell setTitleText: cellModel.cellTitle andValueText: cellModel.cellValue];
	}
}

-(void) startConnectionForCellData {
	static int loadCount;
	
	if ( loadCount == 0 ) {
		ConnectionHandler *handler = [[ConnectionHandler alloc] initWithDelegate: self];
		NSString *path = [[NSString alloc] initWithString: @"celldata.xml"];
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		NSString *url = [[NSString alloc] initWithFormat: @"https://www.marisolintl.com/iphone/homexml.asp?customer=%@", 
						 [defaults objectForKey: kCustomerKey]];
		
		handler.xmlPathComponent = path;
		
		[handler beginURLConnection: url];
		
		[handler release];
		[path release];
		[url release];
		
		loadCount++;
	}
}

-(void) addCellsToHomeScreen {
	for ( int i = 0; i < kNumCells; i++ ) {
		HomeCellViewController *cell = [[HomeCellViewController alloc] initWithNibName: @"HomeCellViewController" bundle: nil];
		
		cell.view.backgroundColor = [UIColor colorWithRed: 0.37 green: 0.37 blue: 0.37 alpha: 1.0];
		
		switch (i) {
			case 0:
				cell.view.frame = CGRectMake(0, 0, 320, 96);
				break;
			case 1:
				cell.view.frame = CGRectMake(0, 105, 320, 96);
				break;
			case 2:
				cell.view.frame = CGRectMake(0, 210, 320, 96);
				break;
			case 3:
				cell.view.frame = CGRectMake(0, 315, 320, 96);
				break;
			default:
				break;
		}
		
		if ( !self.cells ) {
			self.cells = [[NSMutableArray alloc] init];
		}
		
		[self.cells addObject: cell];
		
		[self.view insertSubview: [[self.cells objectAtIndex: i] view] atIndex: 1];
		
		[cell release];
	}
	
	cellsLoaded = YES;

	[self setTabBarViewControllers];
}

#pragma mark -
#pragma mark Connection Handler Delegate Method
-(void) connectionFinishedWithFilePath: (NSString *) filePath {
	XMLParseHandler *handler = [[XMLParseHandler alloc] initWithDelegate: self];
	
	[handler setCallingClass: MIHomeVC];
	
	[handler startXMLParseWithFile: filePath];
	
	[handler release];
}

#pragma mark -
#pragma mark Home XML Parse Handler Delegate Method
-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array {
	[self setCellValuesWithArray: array];
}

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

	cellsLoaded = NO;
	
	if ( ![kUserDefaults boolForKey: kLoggedInKey] ) {
		
		LoginViewController *loginController = [[LoginViewController alloc] initWithNibName: @"LoginViewController" bundle: nil];
		
		[self presentModalViewController: loginController animated: YES];
		
		[loginController release];
	}
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

	if ( [kUserDefaults boolForKey: kLoggedInKey] && cellsLoaded ) {
		[self startConnectionForCellData];
	}
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if ( [kUserDefaults boolForKey: kLoggedInKey] && !cellsLoaded ) {
		[self addCellsToHomeScreen];
	} 
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	self.cells = nil;
}


- (void)dealloc {
	self.cells = nil;
	
    [super dealloc];
}


@end