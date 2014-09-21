//
//  ChatRatingViewController.m
//  VideoChat
//
//  Created by Shub Sengupta on 2014-09-21.
//  Copyright (c) 2014 Ruslan. All rights reserved.
//

#import "ChatRatingViewController.h"
#import "DashboardViewController.h"
#import "Moxtra.h"

@interface ChatRatingViewController ()

@end

@implementation ChatRatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButton:(id)sender {
    DashboardViewController *dash = [[DashboardViewController alloc] init];
    [self presentViewController:dash animated:YES completion:nil];
}

- (IBAction)chatOpenButton:(id)sender {
    [self startChat];
    
    // Fill in the App Client ID and Client Secret Key received from the app registration step from Moxtra
    NSString *APP_CLIENT_ID = @"ug3O_xKRTs4";
    NSString *APP_CLIENT_SECRET = @"k7Lexii75Jg";
    
    // Set up Moxtra SDK
    [Moxtra clientWithApplicationClientID:APP_CLIENT_ID applicationClientSecret:APP_CLIENT_SECRET];

    MXUserIdentity *useridentity = [[MXUserIdentity alloc] init];
    useridentity.userIdentityType = kUserIdentityTypeEmail;

    [[Moxtra sharedClient]
     initializeUserAccount: useridentity
     firstName: nil
     lastName: nil
     avatar: nil
     devicePushNotificationToken: nil
     success: ^{
         NSLog(@"Setup user account successfully");
     } failure: ^(NSError *error) {
         NSLog(@"Setup user account failed, %@", [NSString stringWithFormat:@"error code [%d] description: [%@] info [%@]", [error code], [error localizedDescription], [[error userInfo] description]]);
     }];
}

- (void)startChat {
    [[Moxtra sharedClient] createChat:CGRectMake(290, 538, 50, 50) success:^(NSString *conversationID) {
        NSLog(@"start conversation success, id = %@", conversationID);
        //self.conversationID1 = conversationID;
    } failure:^(NSError *error) {
        NSLog(@"start conversation failed");
    }];
    
    [[Moxtra sharedClient] setDelegate: self];
    return;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end

