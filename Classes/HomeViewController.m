//
//  HomeViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 4/6/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "HomeViewController.h"
#import "RootSearchController.h"
#import "HomeCellViewController.h"
#import "HomeCellModel.h"
#import "LoginViewController.h"

#define kNumCells			4


@implementation HomeViewController

@synthesize cells;

#pragma mark -
#pragma mark Custom Methods
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