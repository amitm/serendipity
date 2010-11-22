    //
//  MapViewController.m
//  Serendipity
//
//  Created by Amit Matani on 11/15/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import "MapViewController.h"
#import "LocateFriendRequest.h"

@implementation MapViewController
@synthesize mapView = _mapView;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

- (id)init {
    if ((self = [super initWithNibName:@"MapView" bundle:nil])) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
	[_mapView release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	_request = [[LocateFriendRequest alloc] initWithDelegate:self];
	[_request findAll];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark LocateFriendRequestDelegate

- (void)locateFriendRequest:(LocateFriendRequest *)locateFriendRequest
			 didFindFriends:(NSArray *)friends {
	[_mapView addAnnotations:friends];
}

@end
