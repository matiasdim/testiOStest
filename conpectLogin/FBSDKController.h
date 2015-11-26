//
//  FBSDKViewController.h
//  conpectLogin
//
//  Created by Matías Gil on 11/12/15.
//  Copyright © 2015 AllianceTech. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FBSDKController : NSObject <FBSDKLoginButtonDelegate>{
    FBSDKLoginButton *loginButton;
}

@property(nonatomic, weak) id delegate;

+ (id)sharedInstance;
-(void)activeApp;
-(BOOL)authenticationStatus;
-(void)fetchUserInfo;
-(FBSDKLoginButton *)getLoginButton;
@end
