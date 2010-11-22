//
//  LocateFriendRequest.m
//  Serendipity
//
//  Created by Amit Matani on 11/15/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import "LocateFriendRequest.h"
#import "FBContainer.h"
#import "Friend.h"

@implementation LocateFriendRequest
@synthesize delegate = _delegate;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class Public

- (id)initWithDelegate:(id<LocateFriendRequestDelegate>)delegate {
	if (self = [self init]) {
		_delegate = delegate;
	}
	return self;
}

- (BOOL)findAll {
	if (_loading) {
		return NO;
	}
	_loading = YES;

	Facebook *facebook = [[FBContainer container] facebook];
	NSMutableDictionary *params = 
		[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"checkin", @"type", nil];
	[facebook requestWithGraphPath:@"search" andParams:params andDelegate:self];
	[params release];
	
	return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class FBRequestDelegate

- (void)request:(FBRequest *)request didLoad:(id)result {
	NSArray *data = [result objectForKey:@"data"];
	if (data == nil || ![data isKindOfClass:[NSArray class]]) {
		// TODO throw error
		return;
	}
	
	NSMutableArray *friends = [[NSMutableArray alloc] init];
	
	for (NSDictionary *friendDict in data) {
		if (![friendDict isKindOfClass:[NSDictionary class]]) {
			continue;
		}
		
		NSDictionary *from = [friendDict objectForKey:@"from"];
		if (![from isKindOfClass:[NSDictionary class]]) {
			continue;
		}
		
		NSString *name = [from objectForKey:@"name"];
		NSString *facebookUserId = [from objectForKey:@"id"];
		
		NSDictionary *place = [friendDict objectForKey:@"place"];
		if (![place isKindOfClass:[NSDictionary class]]) {
			continue;
		}
		
		NSDictionary *location = [place objectForKey:@"location"];
		if (![location isKindOfClass:[NSDictionary class]]) {
			continue;
		}
		
		NSString *longitude = [location objectForKey:@"longitude"];
		NSString *latitude = [location objectForKey:@"latitude"];
		
		CLLocationCoordinate2D coordinate;
		coordinate.latitude = [latitude doubleValue];
		coordinate.longitude = [longitude doubleValue];
		
		Friend *friend = [[Friend alloc] initWithName:name 
									   facebookUserId:facebookUserId
										   coordinate:coordinate];
		[friends addObject:friend];
	}
	
	[_delegate locateFriendRequest:self didFindFriends:friends];
	
	[friends release];
}

@end
