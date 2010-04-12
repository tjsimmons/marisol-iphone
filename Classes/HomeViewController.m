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
#import "HomeCellViewController.h"

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
		
		iStatController.title = viewTitle;
		
		[viewControllers addObject: iStatController];
		[iStatController release];
		[viewTitle release];
	}
	
	if ( exStat ) {
		exStatViewController *exStatController = [[exStatViewController alloc] init];
		
		NSString *viewTitle = [[NSString alloc] initWithString: @"exSTAT"];
		
		exStatController.title = viewTitle;
		
		[viewControllers addObject: exStatController];
		[exStatController release];
		[viewTitle release];
	}
	
	[[[UIApplication sharedApplication] delegate] setTabBarControllers: viewControllers];
	
	[viewControllers release];
	
	[self setCellValues];
}

-(void) setCellValues {
	for ( int i = 0; i < [self.cells count]; i++ ) {
		//HomeCellViewController *cell = (HomeCellViewController *) [cells objectAtIndex: i];
		NSNumber *row = [[NSNumber alloc] initWithInteger: i];
		
		// detach a thread for each cell to keep things snappy
		[NSThread detachNewThreadSelector:@selector(handleConnectionAndXMLForCellAtRow:) toTarget: self withObject: row];
		
		[row release];
	}
}

-(void) handleConnectionAndXMLForCellAtRow: (NSNumber *) row {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	switch ( [row integerValue] ) {
		case 0:
			NSLog(@"1");
			break;
		case 1:
			NSLog(@"2");
			break;
		case 2:
			NSLog(@"3");
			break;
		case 3:
			NSLog(@"4");
			break;
		default:
			NSLog(@"wtf");
			break;
	}
	
	[pool drain];
}

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	for ( int i = 0; i < kNumCells; i++ ) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		HomeCellViewController *cell = [[HomeCellViewController alloc] initWithNibName: @"HomeCellViewController" bundle: nil];
		
		switch (i) {
			case 0:
				cell.view.backgroundColor = [UIColor grayColor];
				cell.view.frame = CGRectMake(0, 0, 320, 96);
				break;
			case 1:
				cell.view.backgroundColor = [UIColor grayColor];
				cell.view.frame = CGRectMake(0, 105, 320, 96);
				break;
			case 2:
				cell.view.backgroundColor = [UIColor grayColor];
				cell.view.frame = CGRectMake(0, 210, 320, 96);
				break;
			case 3:
				cell.view.backgroundColor = [UIColor grayColor];
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
		
		[pool drain];
	}
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
	if ( !pastInitialLogin ) {
		[self setTabBarViewControllers];
	}
}

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

