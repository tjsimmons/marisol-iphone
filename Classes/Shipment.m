//
//  Shipment.m
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "Shipment.h"


@implementation Shipment

@synthesize shipmentID;

@synthesize blNum, marisolNum, shipperName, coordinator, vessel;//, customsStatus;
@synthesize coldStorageDateString, deliveryDateString, clearanceDateString, deliveredDateString;

-(void) dealloc {
	self.blNum = nil;
	self.marisolNum = nil;
	self.shipperName = nil;
	//self.customsStatus = nil;
	self.coordinator = nil;
	self.vessel = nil;
	
	self.coldStorageDateString = nil;
	self.deliveryDateString = nil;
	self.clearanceDateString = nil;
	self.deliveredDateString = nil;
	
	[super dealloc];
}

@end