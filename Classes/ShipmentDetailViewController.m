//
//  ShipmentDetailViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "ShipmentDetailViewController.h"
#import "Shipment.h"


@implementation ShipmentDetailViewController

@synthesize shipment, shipmentDetailTableView;
@synthesize tlFirst, tlSecond, tlThird, tlFourth;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.tlFirst setImage: [UIImage imageNamed: @"tl_green_left.png"]];
	[self.tlSecond setImage: [UIImage imageNamed: @"tl_green_mid.png"]];
	[self.tlThird setImage: [UIImage imageNamed: @"tl_red_mid.png"]];
	[self.tlFourth setImage: [UIImage imageNamed: @"tl_red_right.png"]];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.shipmentDetailTableView = nil;
	
	self.tlFirst = nil;
	self.tlSecond = nil;
	self.tlThird = nil;
	self.tlFourth = nil;
}

- (void)dealloc {
	self.shipment = nil;
	self.shipmentDetailTableView;
	
	self.tlFirst = nil;
	self.tlSecond = nil;
	self.tlThird = nil;
	self.tlFourth = nil;
	
    [super dealloc];
}

#pragma mark -
#pragma mark Table View Data Source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellID = @"CellID";
	
	UITableViewCell *cell = [self.shipmentDetailTableView dequeueReusableCellWithIdentifier: cellID];
	
	if ( cell == nil ) {
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellID];
	}
	
	cell.textLabel.text = [NSString stringWithFormat: @"%i", indexPath.row];
	cell.textLabel.textColor = [UIColor whiteColor];
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

#pragma mark -
#pragma mark Table View Delegate
-(NSIndexPath *)tableView:(UITableView *) tableView willSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	return nil;
}


@end