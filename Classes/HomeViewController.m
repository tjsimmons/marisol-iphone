//
//  HomeViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 4/6/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCellModel.h"
#import "LoginViewController.h"
#import "ChooserViewController.h"

#define kNumCells			4


@implementation HomeViewController

@synthesize customerList, cellInformation;
@synthesize infoTableView;

#pragma mark -
#pragma mark Custom Methods
-(void) startConnectionForCellData {
	static int loadCount;
	
	if ( loadCount == 0 ) {
		ConnectionHandler *handler = [[ConnectionHandler alloc] initWithDelegate: self];
		NSString *path = [[NSString alloc] initWithString: @"celldata.xml"];
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		NSString *url = [[NSString alloc] initWithFormat: @"https://www.marisolintl.com/iphone/homexml.asp?customer=%@", 
						 [defaults objectForKey: kCustomerKey]];
		
		handler.xmlPathComponent = path;
		
		[handler beginURLConnection: url];
		
		[handler release];
		[path release];
		[url release];
		
		loadCount++;
	}
}

-(void) showChooser {
	ChooserViewController *chooserVC = [[ChooserViewController alloc] initWithNibName: @"ChooserViewController" bundle: nil];
	
	[chooserVC setCustomerList: self.customerList];
	
	[self presentModalViewController: chooserVC animated: YES];
}

#pragma mark -
#pragma mark Connection Handler Delegate Method
-(void) connectionFinishedWithFilePath: (NSString *) filePath {
	XMLParseHandler *handler = [[XMLParseHandler alloc] initWithDelegate: self];
	
	[handler setCallingClass: MIHomeVC];
	
	[handler startXMLParseWithFile: filePath];
	
	[handler release];
}

#pragma mark -
#pragma mark Home XML Parse Handler Delegate Method
-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array {
	self.cellInformation = array;
	dataLoaded = YES;

	[self.infoTableView reloadData];
}

#pragma mark -
#pragma mark UITableView Data Source Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellID = @"CellID";
	
	UITableViewCell *cell = [self.infoTableView dequeueReusableCellWithIdentifier: cellID];

	if ( cell == nil ) {
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: cellID] autorelease];
	}
	
	if ( dataLoaded ) {
		HomeCellModel *cellModel = [self.cellInformation objectAtIndex: indexPath.section];
		
		cell.textLabel.text = cellModel.cellTitle;
		cell.detailTextLabel.text = cellModel.cellValue;
	}
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	if ( !dataLoaded ) {
		return 4;
	} else {
		return [self.cellInformation count];
	}
}

#pragma mark -
#pragma mark UITableView Delegate Methods
-(NSIndexPath *) tableView: (UITableView *) tableView willSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.00;
}

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	
	dataLoaded = NO;
	
	if ( ![kUserDefaults boolForKey: kLoggedInKey] ) {
		
		LoginViewController *loginController = [[LoginViewController alloc] initWithNibName: @"LoginViewController" bundle: nil];
		loginController.parentController = self;
		
		[self presentModalViewController: loginController animated: YES];
		
		[loginController release];
	}
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
	if ( [kUserDefaults boolForKey: kLoggedInKey] ) {
		[self startConnectionForCellData];
	} else if ( ![kUserDefaults boolForKey: kLoggedInKey] ) {
		[self performSelector: @selector(showChooser) withObject: nil afterDelay: 0.1];
	}
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
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
	self.infoTableView = nil;
}


- (void)dealloc {
	self.customerList = nil;
	self.cellInformation = nil;
	
	self.infoTableView = nil;

    [super dealloc];
}

@end