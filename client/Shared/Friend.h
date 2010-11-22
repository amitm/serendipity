//
//  Friend.h
//  Serendipity
//
//  Created by Amit Matani on 11/15/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Friend : NSObject <MKAnnotation> {
	NSString *_name;
	NSString *_facebookUserId;
	CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *facebookUserId;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


- (id)initWithName:(NSString *)name facebookUserId:(NSString *)facebookUserId
		coordinate:(CLLocationCoordinate2D)coordinate;

@end
