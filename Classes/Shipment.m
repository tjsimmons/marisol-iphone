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
@synthesize marisolNum;
@synthesize coldStorageDateString;
@synthesize deliveryDateString;

-(void) dealloc {
	self.marisolNum = nil;
	self.coldStorageDateString = nil;
	self.deliveryDateString = nil;
	
	[super dealloc];
}

@end