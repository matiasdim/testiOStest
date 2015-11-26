//
//  FBSDKViewController.m
//  conpectLogin
//
//  Created by Matías Gil on 11/12/15.
//  Copyright © 2015 AllianceTech. All rights reserved.
//

#import "FBSDKController.h"
#import "AuthenticatedViewController.h"

@interface FBSDKController ()

@end

@implementation FBSDKController

static FBSDKController* sharedInstance = nil;

+ (id)sharedInstance {
    if (nil == sharedInstance) {
        sharedInstance = [[FBSDKController alloc]init];
    }
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        loginButton = [[FBSDKLoginButton alloc] init];
        loginButton.delegate = self;
        loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

-(FBSDKLoginButton *)getLoginButton{
    return loginButton;
}

-(void)activeApp
{
    [FBSDKAppEvents activateApp];
}

-(BOOL)authenticationStatus
{
    if ([FBSDKAccessToken currentAccessToken]) {
        return YES;
    };
    return NO;
}

-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 if(self.delegate && [self.delegate respondsToSelector:@selector(saveUserInfo:)]){
                     [self.delegate saveUserInfo:result];
                 }
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
        
    }
    
}

#pragma Delegate methods

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    if (!error) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(successLogin:)]){
            [self.delegate successLogin:result];
        }
    }else{
        if(self.delegate && [self.delegate respondsToSelector:@selector(failedLogin:)]){
            [self.delegate failedLogin:error];
        }
    }
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(closedSession)]) {
        [self.delegate closedSession];
    }
}

@end
