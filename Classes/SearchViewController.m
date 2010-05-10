//
//  SearchViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 5/10/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "SearchViewController.h"
#import "Shipment.h"
#import "ShipmentDetailViewController.h"

#define kCustomerKey	@"customer"


@implementation SearchViewController


@synthesize searchList, connection, MISearchBar, savedSearchTerm, savedScopeButtonIndex, searchWasActive;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Search";
	
	NSArray *scopeButtonTitles = [[NSArray alloc] initWithObjects: @"Marisol #", @"PO #", @"Cold Storage", nil];
	
	self.MISearchBar.scopeButtonTitles = scopeButtonTitles;
	self.MISearchBar.showsCancelButton = YES;
	
	[scopeButtonTitles release];
	
	if ( self.savedSearchTerm ) {
		/*
		 do stuff, as in TableSearch example code
		 */
	}
	
	dataLoaded = NO;
	
	[self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self.MISearchBar becomeFirstResponder];
}

#pragma mark -
#pragma mark Custom Methods

-(void) startConnectionProcessFromSearchBar: (UISearchBar *) searchBar {
	ConnectionHandler *handler = [[ConnectionHandler alloc] initWithDelegate: self];
	NSString *path = [[NSString alloc] initWithFormat: @"%@search.xml", @"istat"];
	NSString *searchField;
	NSString *fieldType;
	NSInteger scopeButtonIndex = [searchBar selectedScopeButtonIndex];
	
	switch ( scopeButtonIndex ) {
		case 0:
			searchField = @"marisol_num";
			fieldType = @"string";
			break;
		case 1:
			searchField = @"purchase_num";
			fieldType = @"string";
			break;
		case 2:
			searchField = @"cold_storage";
			fieldType = @"datetime";
			break;
		default:
			searchField = @"marisol_num";
			fieldType = @"string";
	}
	
	
	NSString *customer = [[NSString alloc] initWithString: [[NSUserDefaults standardUserDefaults] objectForKey: kCustomerKey]];
	
	NSString *url = [[NSString alloc] initWithFormat: @"https://www.marisolintl.com/iphone/shipmentsearchxml.asp?customer=%@&query=%@&field=%@&stat=%@&type=%@",
					 customer, searchBar.text, searchField, @"istat", fieldType];
	
	handler.xmlPathComponent = path;
	
	self.connection = handler;
	[handler release];
	
	[self.connection beginURLConnection: url];
	
	[customer release];
	[path release];
	[url release];
}

#pragma mark -
#pragma mark ConnectionHandler Delegate Method

-(void) connectionFinishedWithFilePath:(NSString *)filePath {
	XMLParseHandler *handler = [[XMLParseHandler alloc] initWithDelegate: self];
	
	[handler startXMLParseWithFile: filePath];
	
	[handler release];
	
	self.connection = nil;
}

#pragma mark -
#pragma mark XMLParseHandler Delegate Method

-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array {
	self.searchList = array;
	
	dataLoaded = YES;
	
	[self.tableView setContentOffset: CGPointMake(0.0, 44.0) animated: YES];
	[self.tableView reloadData];
	[self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	// check for whether the calling table view is the search display or main view
    if ( !dataLoaded ) {
		return 1;
	} else {
		return [self.searchList count];
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell...
	if ( dataLoaded ) {
		Shipment *shipment = [self.searchList objectAtIndex: indexPath.row];
		
		if ( [shipment.marisolNum isEqualToString: @"noshipments"] ) {
			cell.textLabel.text = @"No shipments found.";
		} else {
			cell.textLabel.text = shipment.marisolNum;
		}
	} else {
		cell.textLabel.text = @"";
	}
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.MISearchBar resignFirstResponder];
	
	if ( dataLoaded ) {
		ShipmentDetailViewController *detailViewController = [[ShipmentDetailViewController alloc] initWithNibName: @"ShipmentDetailViewController" bundle: nil];
		
		detailViewController.shipment = [self.searchList objectAtIndex: indexPath.row];
		
		[self.tableView deselectRowAtIndexPath: indexPath animated: YES];
		
		[self.navigationController pushViewController: detailViewController animated: YES];
		
		[detailViewController release];
	}
}

-(NSIndexPath *) tableView: (UITableView *) tableView willSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	if ( dataLoaded ) {
		if ( [[(Shipment *) [self.searchList objectAtIndex: indexPath.row] marisolNum] isEqualToString: @"noshipments"] ) {
			return NO;
		} else {
			return indexPath;
		}
	} else {
		return NO;
	}
}

#pragma mark -
#pragma mark UISearchBar Delegate Methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[self startConnectionProcessFromSearchBar: searchBar];
	
	[searchBar resignFirstResponder];
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	if ( self.connection ) {
		[self.connection stopConnection];
	}
	
	self.searchList = nil;
	
	[self.tableView reloadData];
	
	[self.MISearchBar resignFirstResponder];
	
	/*self.searchList = nil;
	 dataLoaded = NO;
	 
	 [self.tableView reloadData];*/
}

#pragma mark -
#pragma mark UISearchDisplayDelegate Methods


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
	self.searchList = nil;
	self.connection = nil;
	self.MISearchBar = nil;
}


- (void)dealloc {
	self.searchList = nil;
	self.connection = nil;
	self.MISearchBar = nil;
    [super dealloc];
}


@end
