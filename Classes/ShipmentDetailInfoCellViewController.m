//
//  ShipmentDetailInfoCellViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 5/27/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "ShipmentDetailInfoCellViewController.h"


@implementation ShipmentDetailInfoCellViewController

//@synthesize nameLabel, valueLabel;
@synthesize valueLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		//UILabel *label1 = [[UILabel alloc] initWithFrame: CGRectMake(20, 3, 264, 21)];
		UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(20, 3, 264, 38)];
		
		//self.nameLabel = label1;
		self.valueLabel = label;
		
		//[label1 release];
		[label release];
		
		//valueLabel.textAlignment = UITextAlignmentRight;
		
		//[self.contentView addSubview: nameLabel];
		[self.contentView addSubview: valueLabel];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	//self.nameLabel = nil;
	self.valueLabel = nil;
	
    [super dealloc];
}

@end
