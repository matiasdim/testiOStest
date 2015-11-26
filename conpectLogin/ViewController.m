//
//  ViewController.m
//  conpectLogin
//
//  Created by Matías Gil on 11/12/15.
//  Copyright © 2015 AllianceTech. All rights reserved.
//

#import "ViewController.h"
#import "AuthenticatedViewController.h"
#import "FBSDKController.h"
#import "TwitterLoginController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //facebook stuff
    [[FBSDKController sharedInstance] setDelegate:self];
    UIView * fbButton = [[FBSDKController sharedInstance] getLoginButton];
    fbButton.center = self.view.center;
    [self.view addSubview:fbButton];
    
    //twitter stuff
    [[TwitterLoginController sharedInstance] setDelegate:self];
    UIButton *twButtton = [[TwitterLoginController sharedInstance] loginButton];
    twButtton.center = CGPointMake(self.view.center.x, self.view.center.y + 60);
    [self.view addSubview:twButtton];

}

-(void)viewWillAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //active FBApp
    [[FBSDKController sharedInstance] activeApp];
}

#pragma FAcebook login methods
-(void)successLogin:(FBSDKLoginManagerLoginResult *)result{
    [[NSUserDefaults standardUserDefaults] setObject:@{@"facebook":@YES, @"twitter":@NO, @"google":@NO} forKey:@"authenticated"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)failedLogin:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login failed" message:[@"There was an error: " stringByAppendingFormat:@"%@", error.description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma twitter login delegate methods
-(void)twitterSuccesLogin
{
    [[NSUserDefaults standardUserDefaults] setObject:@{@"facebook":@NO, @"twitter":@YES, @"google":@NO} forKey:@"authenticated"];

    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)twitterFailedLogin:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login failed" message:[@"There was an error: " stringByAppendingFormat:@"%@", error.description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

@end
