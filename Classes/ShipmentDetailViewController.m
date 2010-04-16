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

@synthesize shipment;
@synthesize shipmentIDLabel;
@synthesize marisolNumLabel;
@synthesize coldStorageLabel;
@synthesize deliveryDateLabel;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *shipmentIDString = [[NSString alloc] initWithFormat: @"%i", shipment.shipmentID];
	
	self.shipmentIDLabel.text = shipmentIDString;
	self.marisolNumLabel.text = shipment.marisolNum;
	self.deliveryDateLabel.text = shipment.deliveryDateString;
	self.coldStorageLabel.text = shipment.coldStorageDateString;
	
	[shipmentIDString release];
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
	self.shipmentIDLabel = nil;
	self.marisolNumLabel = nil;
	self.coldStorageLabel = nil;
	self.deliveryDateLabel = nil;
}


- (void)dealloc {
	self.shipment = nil;
	self.shipmentIDLabel = nil;
	self.marisolNumLabel = nil;
	self.coldStorageLabel = nil;
	self.deliveryDateLabel = nil;
    [super dealloc];
}


@end