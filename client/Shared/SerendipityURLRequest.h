//
//  SerendipityURLRequest.h
//  Serendipity
//
//  Created by Amit Matani on 11/17/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@interface SerendipityURLRequest : TTURLRequest {
	
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Initializers

+ (SerendipityURLRequest *)requestWithAction:(NSString *)action params:(NSDictionary *)params 
									delegate:(id<TTURLRequestDelegate>)delegate;

- (id)initWithAction:(NSString *)action params:(NSDictionary *)params 
			delegate:(id<TTURLRequestDelegate>)delegate;

@end
