//
//  ShipmentListViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "ShipmentListViewController.h"
#import "ShipmentDetailViewController.h"
#import "Shipment.h"

#define kIStat		@"iSTAT"
#define kExStat		@"exSTAT"


@implementation ShipmentListViewController

@synthesize whichStat;
@synthesize shipmentList;
@synthesize startDate;
@synthesize endDate;

#pragma mark -
#pragma mark Custom Methods
-(void) startConnectionProcess {
	ConnectionHandler *handler = [[ConnectionHandler alloc] initWithDelegate: self];
	NSString *path = [[NSString alloc] initWithFormat: @"%@.xml", self.whichStat];
	
	NSString *customer = @"Primos";
	
	NSString *url = [[NSString alloc] initWithFormat: @"https://www.marisolintl.com/iphone/shipmentxml.asp?customer=%@&start=%@&end=%@", 
					 customer, self.startDate, self.endDate];
	
	handler.xmlPathComponent = path;
	
	[handler beginURLConnection: url];
	
	[handler release];
	[path release];
}

#pragma mark -
#pragma mark Connection Handler Delegate Method
-(void) connectionFinishedWithFilePath:(NSString *)filePath {
	XMLParseHandler *handler = [[XMLParseHandler alloc] initWithDelegate: self];
	
	[handler startXMLParseWithFile: filePath];
	
	[handler release];
}

#pragma mark -
#pragma mark XML Parse Handler Delegate Method
-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array {
	dataLoaded = YES;
	
	self.shipmentList = array;
	
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSMutableArray *array = [[NSMutableArray alloc] initWithObjects: @"firstLoad", nil];
	
	self.shipmentList = array;
	
	dataLoaded = NO;
	
	[array release];
	
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 
 ConnectionHandler *handler = [[ConnectionHandler alloc] initWithDelegate: self];
 NSString *path = [[NSString alloc] initWithFormat: @"%@.xml", self.whichStat];
 
 handler.xmlPathComponent = path;
 
 NSLog(@"path is %@", path);
 
 [handler release];
 [path release];
 }*/

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
    return [self.shipmentList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	if ( dataLoaded ) {
		NSInteger row = [indexPath row];
		Shipment *shipment = [self.shipmentList objectAtIndex: row];
		
		cell.textLabel.text = shipment.marisolNum;
		cell.detailTextLabel.text = shipment.coldStorageDateString;
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	} else {
		cell.textLabel.text = @"Loading...";
	}
    
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
	
	if ( !dataLoaded ) {
		return;
	} else {
		NSInteger row = [indexPath row];
		Shipment *theShipment = [self.shipmentList objectAtIndex: row];
		
		ShipmentDetailViewController *detailController = [[ShipmentDetailViewController alloc] initWithNibName: @"ShipmentDetailViewController" bundle: nil];
		
		detailController.shipment = theShipment;
		
		[self.navigationController pushViewController: detailController animated: YES];
		
		[detailController release];
	}
}

-(void) tableView: (UITableView *) tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *) indexPath {
	NSInteger row = [indexPath row];
	Shipment *theShipment = [self.shipmentList objectAtIndex: row];
	
	ShipmentDetailViewController *detailController = [[ShipmentDetailViewController alloc] initWithNibName: @"ShipmentDetailViewController" bundle: nil];
	
	detailController.shipment = theShipment;
	
	[self.navigationController pushViewController: detailController animated: YES];
	
	[detailController release];
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
	self.whichStat = nil;
}


- (void)dealloc {
	self.whichStat = nil;
	self.shipmentList = nil;
	self.startDate = nil;
	self.endDate = nil;
    [super dealloc];
}


@end

