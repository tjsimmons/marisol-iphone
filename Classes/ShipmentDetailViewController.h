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
	UITableViewCell *timelineCell;
	
	UIImageView *tlImageFirst;
	UIImageView *tlImageSecond;
	UIImageView *tlImageThird;
	UIImageView *tlImageFourth;
	
	UILabel *tlDateFirst;
	UILabel *tlDateSecond;
	UILabel *tlDateThird;
	UILabel *tlDateFourth;
}

@property (nonatomic, retain) Shipment *shipment;
@property (nonatomic, retain) IBOutlet UITableView *shipmentDetailTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell *timelineCell;

@property (nonatomic, retain) IBOutlet UIImageView *tlImageFirst;
@property (nonatomic, retain) IBOutlet UIImageView *tlImageSecond;
@property (nonatomic, retain) IBOutlet UIImageView *tlImageThird;
@property (nonatomic, retain) IBOutlet UIImageView *tlImageFourth;

@property (nonatomic, retain) IBOutlet UILabel *tlDateFirst;
@property (nonatomic, retain) IBOutlet UILabel *tlDateSecond;
@property (nonatomic, retain) IBOutlet UILabel *tlDateThird;
@property (nonatomic, retain) IBOutlet UILabel *tlDateFourth;

-(void) setTimelineImages;

@end
