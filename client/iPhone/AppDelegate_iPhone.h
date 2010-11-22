//
//  AppDelegate_iPhone.h
//  Serendipity
//
//  Created by Amit Matani on 11/14/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate, TTURLRequestDelegate> {
    UIWindow *window;
	UIViewController *_controller;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

