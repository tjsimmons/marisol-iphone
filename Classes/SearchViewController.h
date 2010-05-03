//
//  SearchViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 5/3/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate> {
	NSMutableArray	*searchList;
	
	// as demo'd in Apple's TableSearch example code, saved state of search UI
	NSString		*savedSearchTerm;
	NSInteger		savedScopeButtonIndex;
	BOOL			searchWasActive;
}

@property (nonatomic, retain) NSMutableArray *searchList;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end
