//
//  AppDelegate_iPhone.m
//  Serendipity
//
//  Created by Amit Matani on 11/14/10.
//  Copyright 2010 Digital Masonry, Inc. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "FBContainer.h"

#import "LoginViewController.h"
#import "MapViewController.h"

#import "SerendipityURLRequest.h"
#import "LocationManager.h"

@implementation AppDelegate_iPhone

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	[_controller.view removeFromSuperview];
	[_controller release];
	_controller = nil;
	
	if (![[[FBContainer container] facebook] isSessionValid]) {
		_controller = [[LoginViewController alloc] init];
		[window addSubview:_controller.view];
	} else {
		_controller = [[MapViewController alloc] init];
		[window addSubview:_controller.view];
		
		[[UIApplication sharedApplication]
		 registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
											 UIRemoteNotificationTypeSound |
											 UIRemoteNotificationTypeAlert)];
	}
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	BOOL result = [[[FBContainer container] facebook] handleOpenURL:url];
	Facebook *facebook = [[FBContainer container] facebook];
	NSLog(@"%@", facebook.accessToken);
	return result;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	NSString *pushToken = [[[[(NSString *)deviceToken description]
						stringByReplacingOccurrencesOfString: @"<" withString: @""]
						stringByReplacingOccurrencesOfString: @">" withString: @""]
						stringByReplacingOccurrencesOfString: @" " withString: @""];
	NSDictionary *params = 
		[[NSDictionary alloc] initWithObjectsAndKeys:pushToken, @"device_token", nil];
	SerendipityURLRequest *request = 
		[[SerendipityURLRequest alloc] initWithAction:@"main/register_device" 
											   params:params
											 delegate:self];
	[params release];
	[request send];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
	[_controller release];
    [super dealloc];
}

#pragma mark -
#pragma mark TTURLRequestDelegate

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	[[LocationManager manager] trackLocation];
}


@end
