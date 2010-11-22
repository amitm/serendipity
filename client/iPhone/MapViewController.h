//
//  MapViewController.h
//  Serendipity
//
//  Created by Amit Matani on 11/15/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocateFriendRequest.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, LocateFriendRequestDelegate> {
	MKMapView *_mapView;
	LocateFriendRequest *_request;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end
