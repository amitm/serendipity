//
//  FBContainer.m
//  Serendipity
//
//  Created by Amit Matani on 11/14/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import "FBContainer.h"

static FBContainer *container;
static NSString* kAppId = @"107206069349809";

@implementation FBContainer
@synthesize facebook = _facebook;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class Public

+ (FBContainer *)container {
    @synchronized(self) {
        if (container == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return container;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class NSObject

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (container == nil) {
            container = [super allocWithZone:zone];
            return container;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

- (void)authorize:(id<FBSessionDelegate>)delegate {
	NSArray *permissions = 
		[[NSArray arrayWithObjects:@"user_checkins", @"friends_checkins", 
								   @"offline_access",nil] retain];
	[_facebook authorize:kAppId permissions:permissions delegate:delegate];
	[permissions release];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

- (id)init {
	if (self = [super init]) {
		_facebook = [[Facebook alloc] init];
	}
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {   
    return self;
}


@end
