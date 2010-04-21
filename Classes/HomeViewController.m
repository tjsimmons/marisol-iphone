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
#import "SearchViewController.h"
#import "HomeCellViewController.h"
#import "HomeCellModel.h"

#define kProductsKey		@"products"
#define kNumCells			4


@implementation HomeViewController

@synthesize cells;

#pragma mark -
#pragma mark Custom Methods
-(void) setTabBarViewControllers {
	pastInitialLogin = YES;
	
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
	
	if ( iStat ) {
		iStatViewController *iStatController = [[iStatViewController alloc] init];
		NSString *viewTitle = [[NSString alloc] initWithString: @"iSTAT"];
		UITabBarItem *iTabBarItem = [[UITabBarItem alloc] initWithTitle: viewTitle image: nil tag: 1];
		
		//iStatController.title = viewTitle;
		iStatController.tabBarItem = iTabBarItem;
		
		[viewControllers addObject: iStatController];
		[iStatController release];
		[iTabBarItem release];
		[viewTitle release];
	}
	
	if ( exStat ) {
		exStatViewController *exStatController = [[exStatViewController alloc] init];
		NSString *viewTitle = [[NSString alloc] initWithString: @"exSTAT"];
		UITabBarItem *exTabBarItem = [[UITabBarItem alloc] initWithTitle: viewTitle image: nil tag: 2];
		
		exStatController.title = viewTitle;
		exStatController.tabBarItem = exTabBarItem;
		
		[viewControllers addObject: exStatController];
		[exStatController release];
		[exTabBarItem release];
		[viewTitle release];
	}
	
	// set up the search tab
	SearchViewController *searchController = [[SearchViewController alloc] initWithNibName: @"SearchViewController" bundle: nil];
	NSString *viewTitle = [[NSString alloc] initWithString: @"Search"];
	UITabBarItem *searchTabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem: UITabBarSystemItemSearch tag: 3];
	
	//searchController.title = viewTitle;
	
	searchController.tabBarItem = searchTabBarItem;
	
	[viewControllers addObject: searchController];
	[searchController release];
	[searchTabBarItem release];
	[viewTitle release];
	
	[[[UIApplication sharedApplication] delegate] setTabBarControllers: viewControllers];
	
	[viewControllers release];
	
	[self startConnectionForCellData];
}

-(void) setCellValuesWithArray: (NSArray *) array {
	for ( int i = 0; i < [array count]; i++ ) {
		HomeCellViewController *cell = (HomeCellViewController *) [cells objectAtIndex: i];
		HomeCellModel *cellModel = (HomeCellModel *) [array objectAtIndex: i];
		
		[cell setTitleText: cellModel.cellTitle andValueText: cellModel.cellValue];
	}
}

-(void) startConnectionForCellData {	
	ConnectionHandler *handler = [[ConnectionHandler alloc] initWithDelegate: self];
	NSString *path = [[NSString alloc] initWithString: @"celldata.xml"];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *url = [[NSString alloc] initWithFormat: @"https://www.marisolintl.com/iphone/homexml.asp?customer=%@", 
					 [defaults objectForKey: @"customer"]];
	
	handler.xmlPathComponent = path;
	
	[handler beginURLConnection: url];
	
	[handler release];
	[path release];
	[url release];
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
		
		[self.view insertSubview: cell.view atIndex: 1];
		
		if ( !self.cells ) {
			self.cells = [[NSMutableArray alloc] init];
		}
		
		[self.cells addObject: cell];
		
		[cell release];
	}
}

#pragma mark -
#pragma mark Connection Handler Delegate Method
-(void) connectionFinishedWithFilePath: (NSString *) filePath {
	HomeXMLParseHandler *handler = [[HomeXMLParseHandler alloc] initWithDelegate: self];
	
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
	
    // Uncomment the following line to preserve selection between presentations. OS 3.2 and later?
    //self.clearsSelectionOnViewWillAppear = NO;
	
	[self addCellsToHomeScreen];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
	if ( !pastInitialLogin ) {
		[self setTabBarViewControllers];
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