//
//  Customer.m
//  Marisol
//
//  Created by T.J. Simmons on 5/11/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "Customer.h"


@implementation Customer

@synthesize customerID, customerName, iStat, exStat;

-(void) dealloc {
	self.customerName = nil;
	self.iStat = nil;
	self.exStat = nil;
	
	[super dealloc];
}

@end
