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
	
	NSString *customer = [[NSString alloc] initWithString: [[NSUserDefaults standardUserDefaults] objectForKey: @"Customer"]];
	
	NSString *url = [[NSString alloc] initWithFormat: @"https://www.marisolintl.com/iphone/shipmentxml.asp?customer=%@&start=%@&end=%@", 
					 customer, self.startDate, self.endDate];
	
	handler.xmlPathComponent = path;
	
	[handler beginURLConnection: url];
	
	[customer release];
	[handler release];
	[path release];
	[url release];
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
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return ( [self.shipmentList count] > 0 ? [self.shipmentList count] : 1 );
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    UITableViewCell *cell;
    
    // Configure the cell...
	if ( dataLoaded ) {
		if ( [self.shipmentList count] > 0 ) {
			static NSString *LoadedWithDataID = @"LoadedWithData";
			
			cell = [tableView dequeueReusableCellWithIdentifier: LoadedWithDataID];
			
			if ( cell == nil ) {
				cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: LoadedWithDataID] autorelease];
			}
			
			NSInteger row = [indexPath row];
			Shipment *shipment = [self.shipmentList objectAtIndex: row];
			
			cell.textLabel.text = shipment.marisolNum;
			cell.detailTextLabel.text = shipment.coldStorageDateString;
			cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		} else {
			static NSString *LoadedWithNoDataID = @"LoadedWithNoData";
			
			cell = [tableView dequeueReusableCellWithIdentifier: LoadedWithNoDataID];
			
			if ( cell == nil ) {
				cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: LoadedWithNoDataID] autorelease];
			}
			
			NSString *textString = [[NSString alloc] initWithString: @"No shipments."];
			cell.textLabel.text = textString;
			
			[textString release];
		}
	} else {
		static NSString *LoadedWithNoDataID = @"LoadedWithNoData";
		
		cell = [tableView dequeueReusableCellWithIdentifier: LoadedWithNoDataID];
		
		if ( cell == nil ) {
			cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: LoadedWithNoDataID] autorelease];
		}
		NSString *loadingString = [[NSString alloc] initWithString: @"Loading..."];
		
		cell.textLabel.text = loadingString;
		
		[loadingString release];
	}
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

-(NSIndexPath *) tableView:(UITableView *) tableView willSelectRowAtIndexPath:(NSIndexPath *) indexPath {
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
	
	if ( [cell.textLabel.text isEqualToString: @"No shipments."] ) {
		return nil;
	}
	
	return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ( !dataLoaded ) {
		return;
	} else {
		if ( [self.shipmentList count] > 0 ) {
			NSInteger row = [indexPath row];
			Shipment *theShipment = [self.shipmentList objectAtIndex: row];
			
			ShipmentDetailViewController *detailController = [[ShipmentDetailViewController alloc] initWithNibName: @"ShipmentDetailViewController" bundle: nil];
			
			detailController.shipment = theShipment;
			
			[self.navigationController pushViewController: detailController animated: YES];
			
			[detailController release];
		} else {
			return;
		}
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

