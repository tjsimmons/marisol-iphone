//
//  SearchViewController.h
//  Marisol
//
//  Created by T.J. Simmons on 5/3/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionHandler.h"
#import "XMLParseHandler.h"


@interface SearchViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate, ConnectionHandlerDelegate, XMLParseHandlerDelegate> {
	NSMutableArray	*searchList;
	ConnectionHandler *connection;
	
	// as demo'd in Apple's TableSearch example code, saved state of search UI
	NSString		*savedSearchTerm;
	NSInteger		savedScopeButtonIndex;
	BOOL			searchWasActive;
}

@property (nonatomic, retain) NSMutableArray *searchList;
@property (nonatomic, retain) ConnectionHandler *connection;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

-(void) startConnectionProcessFromSearchBar: (UISearchBar *) searchBar;

// Connection Handler Delegate Method
-(void) connectionFinishedWithFilePath:(NSString *)filePath;

// XML Parse Handler Delegate Method
-(void) xmlDidFinishParsingWithArray: (NSMutableArray *) array;


@end
