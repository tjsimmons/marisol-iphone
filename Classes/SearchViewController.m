//
//  SearchViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 5/3/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "SearchViewController.h"
#import "Shipment.h"

#define kCustomerKey	@"customer"


@implementation SearchViewController

@synthesize searchList, connection, savedSearchTerm, savedScopeButtonIndex, searchWasActive;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Search";
	
	if ( self.savedSearchTerm ) {
		/*
		 do stuff
		 */
	}
	
	[self.tableView reloadData];
	
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
#pragma mark Custom Methods

-(void) startConnectionProcessFromSearchBar: (UISearchBar *) searchBar {
	ConnectionHandler *handler = [[ConnectionHandler alloc] initWithDelegate: self];
	NSString *path = [[NSString alloc] initWithFormat: @"%@search.xml", @"istat"];
	
	NSString *customer = [[NSString alloc] initWithString: [[NSUserDefaults standardUserDefaults] objectForKey: kCustomerKey]];
	
	NSString *url = [[NSString alloc] initWithFormat:
					 @"https://www.marisolintl.com/iphone/shipmentsearchxml.asp?customer=%@&query=%@&field=%@&stat=%@",
					 customer, searchBar.text, @"marisol_num", @"istat"];
	
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
    if ( tableView == self.searchDisplayController.searchResultsTableView ) {
		return [self.searchList count];
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
	if ( tableView == self.searchDisplayController.searchResultsTableView ) {
		Shipment *shipment = [self.searchList objectAtIndex: indexPath.row];
		
		cell.textLabel.text = shipment.marisolNum;
	} else {
		Shipment *shipment = [self.searchList objectAtIndex: indexPath.row];
		
		cell.textLabel.text = shipment.marisolNum;
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
}

#pragma mark -
#pragma mark UISearchBar Delegate Methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[self startConnectionProcessFromSearchBar: searchBar];
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	if ( self.connection ) {
		[self.connection stopConnection];
	}
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
}


- (void)dealloc {
	self.searchList = nil;
	self.connection = nil;
    [super dealloc];
}


@end

