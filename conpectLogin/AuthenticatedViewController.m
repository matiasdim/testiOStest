//
//  AuthenticatedViewController.m
//  conpectLogin
//
//  Created by Matías Gil on 11/12/15.
//  Copyright © 2015 AllianceTech. All rights reserved.
//

#import "AuthenticatedViewController.h"
#import "FBSDKController.h"
#import "TwitterLoginController.h"

@interface AuthenticatedViewController ()

@end

@implementation AuthenticatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated{
}

-(void)viewWillAppear:(BOOL)animated{
    [self verifyLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)verifyLogin{
    // If user is authenticated
    self.logoutTwitterButton.hidden = YES;
    if ([[FBSDKController sharedInstance] authenticationStatus]){
        [[FBSDKController sharedInstance] setDelegate:self];
        
        UIView * loginButton = [[FBSDKController sharedInstance] getLoginButton];
        loginButton.center = self.view.center;
        [self.view addSubview:loginButton];
        
        [[FBSDKController sharedInstance] fetchUserInfo];
    }else if ([[TwitterLoginController sharedInstance] authenticationStatus]){
        [[TwitterLoginController sharedInstance] setDelegate:self];
        [[TwitterLoginController sharedInstance] fetchUserInfo];
        self.logoutTwitterButton.hidden = NO;
        
    }else{
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
}

//fb
-(void)saveUserInfo:(id)result
{
    [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"email"] forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"name"] forKey:@"name"];
//    [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"last_name"] forKey:@"lastName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//fb
-(void)closedSession
{
    [[NSUserDefaults standardUserDefaults] setObject:@{@"facebook":@NO, @"twitter":@NO, @"google":@NO} forKey:@"authenticated"];
    [self removeLoginDataFromDefaults];
    [self verifyLogin];
}

-(void)removeLoginDataFromDefaults
{
    //facebook login
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lastName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //twitter login
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
    
}

//twitter
-(void)saveTwitterUserInfo:(id)result
{
    [[NSUserDefaults standardUserDefaults] setObject:[(TWTRSession *)result userName] forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:[(TWTRSession *)result userID] forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)twitterLogOutButtonTouched:(id)sender {
    self.logoutTwitterButton.hidden = YES;
    [[TwitterLoginController sharedInstance] logout];
    [self verifyLogin];
}

#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
