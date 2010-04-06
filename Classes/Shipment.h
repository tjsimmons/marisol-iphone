//
//  Shipment.h
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Shipment : NSObject {
	NSInteger	shipmentID;
	NSString	*marisolNum;
	NSString	*coldStorageDateString;
	NSString	*deliveryDateString;
}

@property NSInteger shipmentID;
@property (nonatomic, retain) NSString *marisolNum;
@property (nonatomic, retain) NSString *coldStorageDateString;
@property (nonatomic, retain) NSString *deliveryDateString;

@end
