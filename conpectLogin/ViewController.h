//
//  ViewController.h
//  conpectLogin
//
//  Created by Matías Gil on 11/12/15.
//  Copyright © 2015 AllianceTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <TwitterKit/TwitterKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;


-(void)successLogin:(FBSDKLoginManagerLoginResult *)result;
-(void)failedLogin:(NSError *)error;
-(void)twitterSuccesLogin;
-(void)twitterFailedLogin:(NSError *)error;
    
@end

