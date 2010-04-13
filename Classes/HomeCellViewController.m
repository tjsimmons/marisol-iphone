//
//  HomeCellViewController.m
//  Marisol
//
//  Created by T.J. Simmons on 4/12/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "HomeCellViewController.h"


@implementation HomeCellViewController

@synthesize valueLabel;
@synthesize titleLabel;

-(void) setTitleText: (NSString *) titleText andValueText: (NSString *) valueText {
	self.titleLabel.text = titleText;
	self.valueLabel.text = valueText;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.valueLabel = nil;
	self.titleLabel = nil;
}


- (void)dealloc {
	self.valueLabel = nil;
	self.titleLabel = nil;
    [super dealloc];
}


@end
