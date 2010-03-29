//
//  WeekListViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "WeekListViewController.h"
#import "ShipmentListViewController.h"

#define kIStat		@"iSTAT"
#define kExStat		@"exSTAT"


@implementation WeekListViewController

@synthesize whichStat;
@synthesize weekList;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSDictionary *weekDict = [[NSDictionary alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"weeklist" ofType: @"plist"]];
	
	self.weekList = [weekDict objectForKey: @"2010"];
	
	[weekDict release];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSDate *now = [[NSDate alloc] init];
	
	[dateFormatter setDateFormat: @"w"];
	
	NSInteger currentWeek = [[dateFormatter stringFromDate: now] integerValue] - 2;		// subtracting 2 makes this whole thing work. go figure.
	
	// apparently we have to reload the table before we can set the offset. bizarre.
	[self.tableView reloadData];
	// default cell height is 44px, so multiply the week we want by that to set the view to the right week
	[self.tableView setContentOffset: CGPointMake(0.0, currentWeek * 44.0) animated: NO];
	
	[dateFormatter release];
	[now release];
	
	//NSLog(@"week list frame is %.2f, %.2f", self.tableView.frame.size.height, self.tableView.frame.size.width);
	//NSLog(@"superview frame is %.2f, %.2f", self.tableView.superview.frame.size.height, self.tableView.superview.frame.size.width);
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
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
    return [weekList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSInteger row = [indexPath row];
	NSDictionary *cellTextDict = [weekList objectAtIndex: row];
	NSString *weekString = [[NSString alloc] initWithFormat: @"Week %i", row + 1];
	NSString *dateString = [[NSString alloc] initWithFormat: @"%@ - %@", [cellTextDict objectForKey: @"Start"], [cellTextDict objectForKey: @"End"]];
	
	cell.textLabel.text = weekString;
	cell.detailTextLabel.text = dateString;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	[weekString release];
	[dateString release];
	
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	
	ShipmentListViewController *shipmentListViewController = [[ShipmentListViewController alloc] initWithNibName: @"ShipmentListViewController" bundle: nil];
	
	if ( [whichStat isEqualToString: kIStat] ) {
		shipmentListViewController.title = @"iSTAT Shipment List";
		shipmentListViewController.whichStat = kIStat;
	} else {
		shipmentListViewController.title = @"exSTAT Shipment List";
		shipmentListViewController.whichStat = kExStat;
	}
	
	NSInteger row = [indexPath row];
	NSDictionary *cellTextDict = [weekList objectAtIndex: row];
	NSString *start = [[NSString alloc] initWithString: [cellTextDict objectForKey: @"Start"]];
	NSString *end = [[NSString alloc] initWithString: [cellTextDict objectForKey: @"End"]];
	
	shipmentListViewController.startDate = start;
	shipmentListViewController.endDate = end;
	
	[shipmentListViewController startConnectionProcess];
	
	[self.navigationController pushViewController: shipmentListViewController animated: YES];
	
	[start release];
	[end release];
	[shipmentListViewController release];
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
	self.whichStat = nil;
	self.weekList = nil;
    [super dealloc];
}


@end

