//
//  HomeCellModel.h
//  Marisol
//
//  Created by T.J. Simmons on 4/12/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeCellModel : NSObject {
	NSInteger cellIndex;
	NSString *cellTitle;
	NSString *cellValue;
}

@property (nonatomic) NSInteger cellIndex;
@property (nonatomic, retain) NSString *cellTitle;
@property (nonatomic, retain) NSString *cellValue;

@end
