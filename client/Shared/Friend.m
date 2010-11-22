//
//  Friend.m
//  Serendipity
//
//  Created by Amit Matani on 11/15/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import "Friend.h"


@implementation Friend
@synthesize coordinate = _coordinate,
			name = _name,
			facebookUserId = _facebookUserId;


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class Public

- (id)initWithName:(NSString *)name facebookUserId:(NSString *)facebookUserId
		coordinate:(CLLocationCoordinate2D)coordinate {
	if (self = [super init]) {
		_coordinate = coordinate;
		_name = [name copy];
		_facebookUserId = [facebookUserId copy];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class NSObject

- (NSString *)description {
	return [NSString stringWithFormat:@"%@(%@): %f, %f", _name, _facebookUserId, 
														_coordinate.latitude, 
														_coordinate.longitude];
}

- (void)dealloc {
	[_name release];
	[_facebookUserId release];
	[super dealloc];
}

@end
