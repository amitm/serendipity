//
//  LocationManager.m
//  Serendipity
//
//  Created by Amit Matani on 11/21/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import "LocationManager.h"
#import "SerendipityURLRequest.h"

@implementation LocationManager

static LocationManager *manager;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class Public

+ (LocationManager *)manager {
    @synchronized(self) {
        if (manager == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return manager;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class NSObject

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (manager == nil) {
            manager = [super allocWithZone:zone];
            return manager;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

- (void)trackLocation {
	if (nil == _locationManager) {
		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
	}
    [_locationManager startMonitoringSignificantLocationChanges];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

- (id)init {
	if (self = [super init]) {

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

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	
	NSString *latitude = [NSString stringWithFormat:@"%.6f", newLocation.coordinate.latitude];
	NSString *longitude = [NSString stringWithFormat:@"%.6f", newLocation.coordinate.longitude];
	NSDictionary *params = 
		[NSDictionary dictionaryWithObjectsAndKeys:latitude, @"latitude", 
												   longitude, @"longitude", nil];
	
	SerendipityURLRequest *request = 
		[SerendipityURLRequest requestWithAction:@"main/update_location" 
										  params:params 
										delegate:nil];
	[request send];
}

@end
