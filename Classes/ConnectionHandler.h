//
//  ConnectionHandler.h
//  XMLTest2
//
//  Created by T.J. Simmons on 3/24/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionHandlerDelegate;

@interface ConnectionHandler : NSObject {
	id <ConnectionHandlerDelegate> delegate;
	
	// variables to use for XML receiving/writing
	NSMutableData	*receivedData;
	NSString		*xmlFilePath;
	NSString		*xmlPathComponent;
	NSURLConnection *urlConnection;
}

@property (nonatomic, assign) id <ConnectionHandlerDelegate> delegate;

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSString *xmlFilePath;
@property (nonatomic, retain) NSString *xmlPathComponent;
@property (nonatomic, retain) NSURLConnection *urlConnection;

-(id) initWithDelegate: (id) del;
-(void) beginURLConnection: (NSString *) webURL;

@end

@protocol ConnectionHandlerDelegate

-(void) connectionFinishedWithFilePath: (NSString *) filePath;

@end
