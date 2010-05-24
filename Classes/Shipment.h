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
	
	// shipment detail fields
	NSString	*blNum;
	NSString 	*marisolNum;
	NSString	*shipperName;
	// iSTAT only
	NSString	*customsStatus;
	
	// timeline fields
	NSString	*coldStorageDateString;
	NSString	*deliveryDateString;
	NSString 	*clearanceDateString;
	NSString	*dischargeDateString;
}

@property NSInteger shipmentID;

@property (nonatomic, retain) NSString *blNum;
@property (nonatomic, retain) NSString *marisolNum;
@property (nonatomic, retain) NSString *shipperName;
@property (nonatomic, retain) NSString *customsStatus;

@property (nonatomic, retain) NSString *coldStorageDateString;
@property (nonatomic, retain) NSString *deliveryDateString;
@property (nonatomic, retain) NSString *clearanceDateString;
@property (nonatomic, retain) NSString *dischargeDateString;

@end
