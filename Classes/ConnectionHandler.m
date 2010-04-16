//
//  ConnectionHandler.m
//  XMLTest2
//
//  Created by T.J. Simmons on 3/24/10.
//  Copyright 2010 T.J. Simmons. All rights reserved.
//

#import "ConnectionHandler.h"


@implementation ConnectionHandler

@synthesize delegate;

@synthesize receivedData;
@synthesize xmlFilePath;
@synthesize xmlPathComponent;
@synthesize urlConnection;


#pragma mark -
#pragma mark Custom Methods
-(id) initWithDelegate:(id)del {
	if ( self == [super init] ) {
		self.delegate = del;
	}
	
	return self;
}

-(void) beginURLConnection: (NSString *) webURL {
	NSURL			*url = [[NSURL alloc] initWithString: webURL];
	NSURLRequest	*urlRequest = [[NSURLRequest alloc] initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 60.0];
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest: urlRequest delegate: self];
	
	self.urlConnection = conn;
	
	[url release];
	[urlRequest release];
	[conn release];
	
	if ( urlConnection ) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		
		receivedData = [[NSMutableData data] retain];
	}
}

#pragma mark -
#pragma mark NSURLConnection Delegate Methods
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[receivedData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData: data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	self.xmlFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent: self.xmlPathComponent];
	
	[receivedData writeToFile: xmlFilePath atomically: YES];
	
	// Apple did it; so did I.
	self.receivedData = nil;
	self.urlConnection = nil;
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[delegate connectionFinishedWithFilePath: xmlFilePath];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	// when in doubt, do as Apple does
	self.receivedData = nil;
	self.urlConnection = nil;
}

#pragma mark -
#pragma mark Memory Management
-(void) dealloc {
	[receivedData release];
	[xmlFilePath release];
	[xmlPathComponent release];
	
	// cancel our connection, in case it's still running
	[urlConnection cancel];
	[urlConnection release];
	
	[super dealloc];
}

@end