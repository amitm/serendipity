//
//  SerendipityURLRequest.m
//  Serendipity
//
//  Created by Amit Matani on 11/17/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import "SerendipityURLRequest.h"
#import "FBContainer.h"

@implementation SerendipityURLRequest

static NSString *kBaseURL = @"http://24.5.76.199:5000";


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class Private

+ (NSString *)generateURLPathFromAction:(NSString *)action {
	return [NSString stringWithFormat:@"%@/%@", kBaseURL, action];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class Public

+ (SerendipityURLRequest *)requestWithAction:(NSString *)action params:(NSDictionary *)params 
								  delegate:(id<TTURLRequestDelegate>)delegate {
	return [[[SerendipityURLRequest alloc] initWithAction:action 
												  params:params 
												delegate:delegate] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

- (id)initWithAction:(NSString *)action params:(NSDictionary *)params 
			delegate:(id<TTURLRequestDelegate>)delegate {
	NSString *url = [[self class] generateURLPathFromAction:action];
	
	if (self = [super initWithURL:url delegate:delegate]) {
		NSString *accessToken = [[FBContainer container] facebook].accessToken;
		if (accessToken != nil) {
			[self.parameters setObject:accessToken forKey:@"access_token"];
		}
		[self.parameters addEntriesFromDictionary:params];
		self.httpMethod = @"POST";
		self.cachePolicy = TTURLRequestCachePolicyNoCache;
	}
	
	return self;
}

@end
