//
//  LoginViewController.m
//  Serendipity
//
//  Created by Amit Matani on 11/15/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import "LoginViewController.h"
#import "FBContainer.h"
#import "SerendipityURLRequest.h"


@implementation LoginViewController
@synthesize fbLoginButton = _fbLoginButton;


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

- (IBAction)fbLoginButtonSelected {
	[[FBContainer container] authorize:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark FBSessionDelegate

- (void)fbDidLogin {
}

- (void)fbDidNotLogin:(BOOL)cancelled {}

- (void)fbDidLogout {}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

- (id)init {
    if ((self = [super initWithNibName:@"LoginView" bundle:nil])) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
	[_fbLoginButton release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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


@end
