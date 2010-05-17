//
//  ChooserViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 5/11/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "ChooserViewController.h"
#import "Customer.h"


@implementation ChooserViewController

@synthesize customerList, MItableView, lastCheckedCell;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//self.view.frame = CGRectMake(0, 0, 320, 480);
	
	self.MItableView.delegate = self;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [customerList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ChooserCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    Customer *customer = (Customer *) [customerList objectAtIndex: indexPath.row];
	
	cell.textLabel.text = customer.customerName;
	
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *sectionTitle = [[[NSString alloc] initWithString: @"Choose an active customer"] autorelease];
	
	return sectionTitle;
}

#pragma mark -
#pragma mark Table view delegate
-(IBAction) cancel {
	[self dismissModalViewControllerAnimated: YES];
	NSLog(@"istat %i", [kUserDefaults boolForKey: kIstatKey]);
	NSLog(@"customer %@", [kUserDefaults objectForKey: kCustomerKey]);
}

-(IBAction) setCustomer {
	if ( self.lastCheckedCell ) {
		Customer *customer = (Customer *) [customerList objectAtIndex: self.lastCheckedCell.row];
		
		[kUserDefaults setObject: customer.customerName forKey: kCustomerKey];
		[kUserDefaults setObject: customer.iStat forKey: kIstatKey];
		[kUserDefaults setObject: customer.exStat forKey: kExstatKey];
		[kUserDefaults setBool: YES forKey: kLoggedInKey];
		
		[self dismissModalViewControllerAnimated: YES];
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert"
														message: @"Please choose a customer or press cancel." delegate: nil cancelButtonTitle: @"Okay" 
											  otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *chosenCell = [self.MItableView cellForRowAtIndexPath: indexPath];
	
	if ( self.lastCheckedCell ) {
		UITableViewCell *previousCell = [self.MItableView cellForRowAtIndexPath: self.lastCheckedCell];
		
		[previousCell setAccessoryType: UITableViewCellAccessoryNone];
	}
	
	[chosenCell setAccessoryType: UITableViewCellAccessoryCheckmark];
	self.lastCheckedCell = indexPath;
	
	[self.MItableView deselectRowAtIndexPath: indexPath animated: YES];
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
	self.MItableView = nil;
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear: animated];
}

-(void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

-(void) viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear: animated];
}


- (void)dealloc {
	self.customerList = nil;
	self.MItableView = nil;
	self.lastCheckedCell = nil;
	
    [super dealloc];
}


@end

