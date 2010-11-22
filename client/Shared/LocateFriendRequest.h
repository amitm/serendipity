//
//  LocateFriendRequest.h
//  Serendipity
//
//  Created by Amit Matani on 11/15/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"

@protocol LocateFriendRequestDelegate;
@interface LocateFriendRequest : NSObject <FBRequestDelegate> {
	id<LocateFriendRequestDelegate> _delegate;
	BOOL _loading;
}

@property (nonatomic, assign) id<LocateFriendRequestDelegate> delegate;

- (id)initWithDelegate:(id<LocateFriendRequestDelegate>)delegate;
- (BOOL)findAll;

@end

@protocol LocateFriendRequestDelegate <NSObject>

- (void)locateFriendRequest:(LocateFriendRequest *)locateFriendRequest
			 didFindFriends:(NSArray *)friends;

@end