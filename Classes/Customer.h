//
//  Customer.h
//  Marisol
//
//  Created by T.J. Simmons on 5/11/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Customer : NSObject {
	NSInteger	customerID;
	NSString	*customerName;
	NSString	*iStat;
	NSString	*exStat;
}

@property NSInteger customerID;
@property (nonatomic, retain) NSString *customerName;
@property (nonatomic, retain) NSString *iStat, *exStat;

@end
