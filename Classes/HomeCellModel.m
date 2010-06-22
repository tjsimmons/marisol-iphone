//
//  HomeCellModel.m
//  Marisol
//
//  Created by T.J. Simmons on 4/12/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "HomeCellModel.h"


@implementation HomeCellModel

//@synthesize cellIndex;
@synthesize cellTitle;
@synthesize cellValue;

-(void) dealloc {
	self.cellTitle = nil;
	self.cellValue = nil;
	
	[super dealloc];
}

@end