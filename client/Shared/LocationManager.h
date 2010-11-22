//
//  LocationManager.h
//  Serendipity
//
//  Created by Amit Matani on 11/21/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *_locationManager;
}

+ (LocationManager *)manager;
- (void)trackLocation;

@end
