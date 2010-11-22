//
//  FBContainer.h
//  Serendipity
//
//  Created by Amit Matani on 11/14/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"

@interface FBContainer : NSObject {
	Facebook *_facebook;
}

@property (nonatomic, readonly) Facebook *facebook;

+ (FBContainer *)container;
- (void)authorize:(id<FBSessionDelegate>)delegate;

@end
