//
//  SpalshViewController.m
//  SimpleSample-videochat-ios
//
//  Created by QuickBlox team on 1/02/13.
//  Copyright (c) 2013 QuickBlox. All rights reserved.
//

#import "SplashViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"

@interface SplashViewController ()

@end

@implementation SplashViewController
@synthesize activityIndicator;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)logInAsUser:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.currentUser = 1; // for some reason this needs to match the user logging in
    
    // Create a QB Session
    QBSessionParameters *parameters = [QBSessionParameters new];
    parameters.userLogin = self.userName.text;
    parameters.userPassword = self.userPass.text;
    
    // QuickBlox session creation
    [QBRequest createSessionWithExtendedParameters:parameters successBlock:^(QBResponse *response, QBASession *session) {
        [self loginToChat:session];
        
    } errorBlock:[self handleError]];
    
    // Start the activity indicator and disable unnecessary fields
    [activityIndicator startAnimating];
    self.userName.enabled = NO;
    self.userPass.enabled = NO;
}

- (void(^)(QBResponse *))handleError
{
    return ^(QBResponse *response) {
        self.userName.enabled = YES;
        self.userPass.enabled = YES;
        [activityIndicator stopAnimating];
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", "")
//                                                        message:[response.error description]
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"OK", "")
//                                              otherButtonTitles:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry","")
                                                        message: @"Your username or password is invalid"
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", "")
                                              otherButtonTitles:nil];
        [alert show];
    };
}

- (void)loginToChat:(QBASession *)session{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    // Set QuickBlox Chat delegate
    //
    [QBChat instance].delegate = self;
    
    QBUUser *user = [QBUUser user];
    user.ID = session.userID;
    user.password = appDelegate.currentUser == 1 ? appDelegate.testOpponents[1] : appDelegate.testOpponents[4];
    
    // Login to QuickBlox Chat
    //
    [[QBChat instance] loginWithUser:user];
}


#pragma mark -
#pragma mark QBChatDelegate

- (void)chatDidLogin{
    // Show Main controller
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    MainViewController *mainViewController = [[MainViewController alloc] init];
    mainViewController.opponentID = appDelegate.currentUser == 1 ? appDelegate.testOpponents[5] : appDelegate.testOpponents[2];
    [self presentViewController:mainViewController animated:YES completion:nil];
}

- (void)chatDidNotLogin{
    loginAsUser1Button.enabled = YES;
    loginAsUser2Button.enabled = YES;
}

@end
