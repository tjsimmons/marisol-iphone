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

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	shipmentIDLabel.text = [NSString stringWithFormat: @"%i", shipment.shipmentID];
	marisolNumLabel.text = shipment.marisolNum;
	coldStorageLabel.text = shipment.coldStorageDateString;
	deliveryDateLabel.text = shipment.deliveryDateString;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
