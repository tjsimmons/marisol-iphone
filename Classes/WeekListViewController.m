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
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section
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

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShipmentListViewController *shipmentListViewController = [[ShipmentListViewController alloc] initWithStyle: UITableViewStylePlain];
	
	if ( [self.title isEqualToString: kIStat] ) {
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
	self.weekList = nil;
}


- (void)dealloc {
	self.weekList = nil;
    [super dealloc];
}


@end

