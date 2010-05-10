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
#define kProductsKey	@"products"
#define kIStat			@"iStat"
#define kExStat			@"exStat"
#define kBoth			@"iStatexStat"

#define kIStatButtonIndex	0
#define kExStatButtonIndex	1
#define kCancelButtonIndex	2


@implementation SearchViewController


@synthesize searchList, connection, MISearchBar, savedSearchTerm, savedScopeButtonIndex, searchWasActive, whichStat;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Search";
	
	self.whichStat = [[NSUserDefaults standardUserDefaults] objectForKey: kProductsKey];
	
	if ( [self.whichStat isEqualToString: kBoth] ) {
		UIBarButtonItem *productButton = [[UIBarButtonItem alloc] initWithTitle: @"Change" style: UIBarButtonItemStyleBordered 
																		 target: self action: @selector(changeActiveProduct)];
		
		self.navigationItem.rightBarButtonItem = productButton;
		
		[productButton release];
	}
	
	if ( [self.whichStat isEqualToString: kIStat] ) {
		self.MISearchBar.placeholder = @"Search iSTAT";
	} else if ( [self.whichStat isEqualToString: kExStat] ) {
		self.MISearchBar.placeholder = @"Search exSTAT";
	}
	
	NSArray *scopeButtonTitles = [[NSArray alloc] initWithObjects: @"Marisol #", @"PO #", @"Cold Storage", nil];
	
	self.MISearchBar.scopeButtonTitles = scopeButtonTitles;
	
	[scopeButtonTitles release];
	
	if ( self.savedSearchTerm ) {
		[self.searchDisplayController setActive: self.searchWasActive];
		[self.searchDisplayController.searchBar setSelectedScopeButtonIndex: self.savedScopeButtonIndex];
		[self.searchDisplayController.searchBar setText: self.savedSearchTerm];
	}
	
	dataLoaded = NO;
	
	[self.tableView reloadData];
	
	[self callActionSheet];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

-(void) viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear: animated];
	
	self.searchWasActive = [self.searchDisplayController isActive];
	self.savedSearchTerm = [self.searchDisplayController.searchBar text];
	self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}

#pragma mark -
#pragma mark Custom Methods

-(void) startConnectionProcessFromSearchBar: (UISearchBar *) searchBar {
	ConnectionHandler *handler = [[ConnectionHandler alloc] initWithDelegate: self];
	NSString *path = [[NSString alloc] initWithFormat: @"%@search.xml", self.whichStat];
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
					 customer, searchBar.text, searchField, self.whichStat, fieldType];
	
	handler.xmlPathComponent = path;
	
	self.connection = handler;
	[handler release];
	
	[self.connection beginURLConnection: url];
	
	[customer release];
	[path release];
	[url release];
}

-(void) callActionSheet {
	if ( [self.whichStat isEqualToString: kBoth] ) {
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: @"Please select a product:" delegate: self cancelButtonTitle: @"Cancel" 
												   destructiveButtonTitle: nil otherButtonTitles: @"iSTAT", @"exSTAT", nil];
		
		[actionSheet showFromTabBar: [[[[UIApplication sharedApplication] delegate] tabBarController] tabBar]];
		[actionSheet release];
	}
}

-(void) changeActiveProduct {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: @"Please select a product:" delegate: self cancelButtonTitle: @"Cancel" 
											   destructiveButtonTitle: nil otherButtonTitles: @"iSTAT", @"exSTAT", nil];
	
	[actionSheet showFromTabBar: [[[[UIApplication sharedApplication] delegate] tabBarController] tabBar]];
	[actionSheet release];
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
#pragma mark UIActionSheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	switch ( buttonIndex ) {
		case kCancelButtonIndex:
			self.MISearchBar.userInteractionEnabled = NO;
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert"
															message: @"Please choose a product to search"
														   delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
			[alert show];
			[alert release];
			break;
		case kIStatButtonIndex:
			self.whichStat = kIStat;
			self.MISearchBar.userInteractionEnabled = YES;
			self.MISearchBar.placeholder = @"Search iSTAT";
			break;
		case kExStatButtonIndex:
			self.whichStat = kExStat;
			self.MISearchBar.userInteractionEnabled = YES;
			self.MISearchBar.placeholder = @"Search exSTAT";
			break;
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
	
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
	self.searchList = nil;
	self.connection = nil;
	self.MISearchBar = nil;
	self.whichStat = nil;
}


- (void)dealloc {
	self.searchList = nil;
	self.connection = nil;
	self.MISearchBar = nil;
	self.whichStat = nil;
	
    [super dealloc];
}


@end
