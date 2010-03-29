//
//  ShipmentDetailViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Shipment;

@interface ShipmentDetailViewController : UIViewController {
	Shipment *shipment;
	
	UILabel *shipmentIDLabel;
	UILabel *marisolNumLabel;
	UILabel *coldStorageLabel;
	UILabel *deliveryDateLabel;
}

@property (nonatomic, retain) Shipment *shipment;

@property (nonatomic, retain) IBOutlet UILabel *shipmentIDLabel;
@property (nonatomic, retain) IBOutlet UILabel *marisolNumLabel;
@property (nonatomic, retain) IBOutlet UILabel *coldStorageLabel;
@property (nonatomic, retain) IBOutlet UILabel *deliveryDateLabel;

@end
