//
//  ShipmentDetailViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "ShipmentDetailViewController.h"
#import "ShipmentDetailInfoCellViewController.h"
#import "Shipment.h"


@implementation ShipmentDetailViewController

@synthesize shipment, shipmentDetailTableView, timelineCell;
@synthesize tlImageFirst, tlImageSecond, tlImageThird, tlImageFourth;
@synthesize tlDateFirst, tlDateSecond, tlDateThird, tlDateFourth;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	self.tlDateFirst.text = [shipment coldStorageDateString];
	self.tlDateSecond.text = [shipment clearanceDateString];
	self.tlDateThird.text = [shipment deliveryDateString];
	self.tlDateFourth.text = [shipment deliveredDateString];
	
	[self setTimelineImages];
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
	self.timelineCell = nil;
	
	self.tlImageFirst = nil;
	self.tlImageSecond = nil;
	self.tlImageThird = nil;
	self.tlImageFourth = nil;
}

- (void)dealloc {
	self.shipment = nil;
	self.shipmentDetailTableView = nil;
	self.timelineCell = nil;
	
	self.tlImageFirst = nil;
	self.tlImageSecond = nil;
	self.tlImageThird = nil;
	self.tlImageFourth = nil;
	
    [super dealloc];
}

#pragma mark -
#pragma mark Custom Methods
-(void) setTimelineImages {
	if ( [self.tlDateFirst.text isEqualToString: @""] ) {
		self.tlImageFirst.image = [UIImage imageNamed: @"tl_grey_left.png"];
	} else {
		self.tlImageFirst.image = [UIImage imageNamed: @"tl_green_left.png"];
	}
	
	if ( [self.tlDateSecond.text isEqualToString: @""] ) {
		self.tlImageSecond.image = [UIImage imageNamed: @"tl_grey_mid.png"];
	} else {
		self.tlImageSecond.image = [UIImage imageNamed: @"tl_green_mid.png"];
	}
	
	if ( [self.tlDateThird.text isEqualToString: @""] ) {
		self.tlImageThird.image = [UIImage imageNamed: @"tl_grey_mid.png"];
	} else {
		self.tlImageThird.image = [UIImage imageNamed: @"tl_green_mid.png"];
	}
	
	if ( [self.tlDateFourth.text isEqualToString: @""] ) {
		self.tlImageFourth.image = [UIImage imageNamed: @"tl_grey_right.png"];
	} else {
		self.tlImageFourth.image = [UIImage imageNamed: @"tl_green_right.png"];
	}
}

#pragma mark -
#pragma mark Table View Data Source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellID = @"InfoCellID";

	if ( indexPath.section == 0 ) {
		return self.timelineCell;
	} else {
		ShipmentDetailInfoCellViewController *cell = (ShipmentDetailInfoCellViewController *) [self.shipmentDetailTableView dequeueReusableCellWithIdentifier: cellID];
		
		if ( cell == nil ) {
			cell = [[ShipmentDetailInfoCellViewController alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellID];
		}
		
		switch ( indexPath.row ) {
			case 0:
				cell.nameLabel.text = @"BL #";
				cell.valueLabel.text = self.shipment.blNum;
				break;
			case 1:
				cell.nameLabel.text = @"Shipper";
				cell.valueLabel.text = self.shipment.shipperName;
				break;
			case 2:
				cell.nameLabel.text = @"Something";
				cell.valueLabel.text = @"Random value";
				break;
			case 3:
				cell.nameLabel.text = @"Something else";
				cell.valueLabel.text = @"Another random value";
				break;
		}
		
		return cell;
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if ( section == 0 ) {
		return 1;
	} else {
		return 4;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ( section == 1 ) {
		return @"Shipment Details";
	} else {
		return nil;
	}
}

#pragma mark -
#pragma mark Table View Delegate
-(NSIndexPath *)tableView:(UITableView *) tableView willSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath { 
	if ( indexPath.section == 0 ) {
		return 63.0;
	} else {
		return 44.0;
	}
}


@end