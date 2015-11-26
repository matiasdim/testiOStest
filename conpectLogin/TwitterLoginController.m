//
//  TwitterLoginController.m
//  conpectLogin
//
//  Created by Matías Gil on 11/19/15.
//  Copyright © 2015 AllianceTech. All rights reserved.
//

#import "TwitterLoginController.h"
#import "ViewController.h"
#import "AuthenticatedViewController.h"
#import "MBProgressHUD.h"


@implementation TwitterLoginController

static TwitterLoginController* sharedInstance = nil;

+ (id)sharedInstance {
    if (nil == sharedInstance) {
        sharedInstance = [[TwitterLoginController alloc]init];
    }
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

-(TWTRLogInButton *)loginButton
{
    __weak TwitterLoginController *weakself = self;
    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            // Callback for login success or failure. The TWTRSession
            // is also available on the [Twitter sharedInstance]
            // singleton.
            //
            // Here we pop an alert just to give an example of how
            // to read Twitter user info out of a TWTRSession.
            //
            // TODO: Remove alert and use the TWTRSession's userID
            // with your app's user model
            
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(twitterSuccesLogin)]) {
                [weakself.delegate twitterSuccesLogin];
            }

        } else {
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(failedLogin:)]) {
                [weakself.delegate failedLogin:error];
            }
        }
    }];
    
    // TODO: Change where the log in button is positioned in your view
    return logInButton;
}

-(BOOL)authenticationStatus
{
    if ([[Twitter sharedInstance] session]) {
        return YES;
    };
    return NO;
}

-(void)fetchUserInfo
{
    if ([[Twitter sharedInstance] session]) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(saveTwitterUserInfo:)]){
            [self.delegate saveTwitterUserInfo:[[Twitter sharedInstance] session]];
        }
    }
}

-(void)logout
{
    [[Twitter sharedInstance] logOut];
}
@end
