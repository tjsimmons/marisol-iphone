//
//  ShipmentDetailViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 3/28/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Shipment;

@interface ShipmentDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	Shipment *shipment;
	UITableView *shipmentDetailTableView;
	UIImageView *tlFirst;
	UIImageView *tlSecond;
	UIImageView *tlThird;
	UIImageView *tlFourth;
}

@property (nonatomic, retain) Shipment *shipment;
@property (nonatomic, retain) IBOutlet UITableView *shipmentDetailTableView;
@property (nonatomic, retain) IBOutlet UIImageView *tlFirst;
@property (nonatomic, retain) IBOutlet UIImageView *tlSecond;
@property (nonatomic, retain) IBOutlet UIImageView *tlThird;
@property (nonatomic, retain) IBOutlet UIImageView *tlFourth;

@end
