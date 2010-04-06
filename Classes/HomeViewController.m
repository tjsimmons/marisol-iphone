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

#define kProductsKey		@"products"
#define kHomeCellHeight		102


@implementation HomeViewController

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

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

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
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	// load up our custom cell
	if ( cell == nil ) {
		NSArray		*nib = [[NSBundle mainBundle] loadNibNamed: @"HomeCell"
													  owner: self options: nil];
		
		for ( id oneObject in nib ) {
			if ( [oneObject isKindOfClass: [UITableViewCell class]] ) {
				cell = oneObject;
			}
		}
	}
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate
// this sets the height for every row called for by table
-(CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
	return kHomeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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
}


- (void)dealloc {
    [super dealloc];
}


@end

