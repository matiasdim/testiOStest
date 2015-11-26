//
//  TwitterLoginControllerTests.m
//  conpectLogin
//
//  Created by Matías Gil on 11/24/15.
//  Copyright © 2015 AllianceTech. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TwitterLoginController.h"

@interface TwitterLoginControllerTests : XCTestCase

@end

@implementation TwitterLoginControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - helper methods

- (TwitterLoginController *)createUniqueInstance {
    
    return [[TwitterLoginController alloc] init];
    
}

- (TwitterLoginController *)getSharedInstance {
    
    return [TwitterLoginController sharedInstance];
}

#pragma mark - tests

- (void)testSingletonSharedInstanceCreated {
    
    XCTAssertNotNil([self getSharedInstance]);
    
}

- (void)testSingletonUniqueInstanceCreated {
    
    XCTAssertNotNil([self createUniqueInstance]);
    
}

- (void)testSingletonReturnsSameSharedInstanceTwice {
    
    TwitterLoginController *sharedInstance = [self getSharedInstance];
    XCTAssertEqual(sharedInstance, [self getSharedInstance]);
    
}

- (void)testSingletonSharedInstanceSeparateFromUniqueInstance {
    
    TwitterLoginController *sharedInstance = [self getSharedInstance];
    XCTAssertNotEqual(sharedInstance, [self createUniqueInstance]);
}

- (void)testSingletonReturnsSeparateUniqueInstances {
    
    TwitterLoginController *sharedInstance = [self createUniqueInstance];
    XCTAssertNotEqual(sharedInstance, [self createUniqueInstance]);
}


-(void)testLoginButton
{
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method"];
    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            XCTAssertNotNil(session, @"Session initiated");
            
        } else {
            XCTAssertNotNil(error, @"Login error");
        }
        [completionExpectation fulfill];
    }];
    
    [logInButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

-(void)testAuthenticationStatus
{
    TwitterLoginController *sharedInstance = [self createUniqueInstance];
    
}
@end
