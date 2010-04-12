//
//  HomeCellViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 4/12/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeCellViewController : UIViewController {
	UILabel *valueLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *valueLabel;

-(void) setValueText: (NSString *) text;

@end
