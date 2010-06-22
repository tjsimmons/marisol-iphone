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
@synthesize firstCell, secondCell, thirdCell, fourthCell;

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

-(void) setCellValues {
	/*UITableViewCell *cell;
	 UILabel *titleLabel;
	 UILabel *valueLabel;
	 HomeCellModel *cellModel;
	 
	 for ( int i = 0; i < [self.cellInformation count]; i++ ) {
	 cellModel = (HomeCellModel *) [self.cellInformation objectAtIndex: i];
	 
	 switch ( i ) {
	 case 0:
	 cell = self.firstCell;
	 titleLabel = (UILabel *) [cell viewWithTag: MIFirstTitleTag];
	 valueLabel = (UILabel *) [cell viewWithTag: MIFirstValueTag];
	 
	 break;
	 case 1:
	 cell = self.secondCell;
	 titleLabel = (UILabel *) [cell viewWithTag: MISecondTitleTag];
	 valueLabel = (UILabel *) [cell viewWithTag: MISecondValueTag];
	 
	 break;
	 case 2:
	 cell = self.thirdCell;
	 titleLabel = (UILabel *) [cell viewWithTag: MIThirdTitleTag];
	 valueLabel = (UILabel *) [cell viewWithTag: MIThirdValueTag];
	 
	 break;
	 case 3:
	 cell = self.fourthCell;
	 titleLabel = (UILabel *) [cell viewWithTag: MIFourthTitleTag];
	 valueLabel = (UILabel *) [cell viewWithTag: MIFourthValueTag];
	 
	 break;
	 default:
	 break;
	 }
	 
	 titleLabel.text = cellModel.cellTitle;
	 valueLabel.text = cellModel.cellValue;
	 }*/
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
	
	//[self setCellValues];
	[self.infoTableView reloadData];
}

#pragma mark -
#pragma mark UITableView Data Source Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	/*UITableViewCell *cell;
	 
	 switch ( indexPath.row ) {
	 case 0:
	 cell = self.firstCell;
	 break;
	 case 1:
	 cell = self.secondCell;
	 break;
	 case 2:
	 cell = self.thirdCell;
	 break;
	 case 3:
	 cell = self.fourthCell;
	 break;
	 default:
	 return nil;
	 break;
	 }
	 
	 return cell;*/
	
	static NSString *cellID = @"CellID";
	
	UITableViewCell *cell = [self.infoTableView dequeueReusableCellWithIdentifier: cellID];
	
	if ( cell == nil ) {
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellID] autorelease];
		
		//cell.contentView.backgroundColor = [UIColor whiteColor];
		
		switch ( indexPath.section ) {
			case 0:
				cell.textLabel.text = @"1";
				break;
			case 1:
				cell.textLabel.text = @"2";
				break;
			case 2:
				cell.textLabel.text = @"3";
				break;
			case 3:
				cell.textLabel.text = @"4";
				break;
			default:
				break;
		}
	}
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//return kNumCells;
	return 1;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 4;
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
	
	self.firstCell = nil;
	self.secondCell = nil;
	self.thirdCell = nil;
	self.fourthCell = nil;
}


- (void)dealloc {
	self.customerList = nil;
	self.cellInformation = nil;
	
	self.infoTableView = nil;
	
	self.firstCell = nil;
	self.secondCell = nil;
	self.thirdCell = nil;
	self.fourthCell = nil;
	
    [super dealloc];
}


@end