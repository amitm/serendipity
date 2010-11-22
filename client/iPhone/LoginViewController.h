//
//  LoginViewController.h
//  Serendipity
//
//  Created by Amit Matani on 11/15/10.
//  Copyright 2010 Miraphonic, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface LoginViewController : UIViewController <FBSessionDelegate> {
	UIButton *_fbLoginButton;
}

@property (nonatomic, retain) IBOutlet UIButton *fbLoginButton;

- (IBAction)fbLoginButtonSelected;

@end
