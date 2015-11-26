//
//  AuthenticatedViewController.h
//  conpectLogin
//
//  Created by Matías Gil on 11/12/15.
//  Copyright © 2015 AllianceTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthenticatedViewController : UIViewController

-(void)closedSession;
-(void)saveUserInfo:(id)result;
-(void)saveTwitterUserInfo:(id)result;
- (IBAction)twitterLogOutButtonTouched:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *logoutTwitterButton;
@end
