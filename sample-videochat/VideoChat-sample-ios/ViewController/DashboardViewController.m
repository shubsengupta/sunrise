//
//  DashboardViewController.m
//  VideoChat
//
//  Created by Ali Dinani on 2014-09-20.
//  Copyright (c) 2014 Ruslan. All rights reserved.
//

#import "DashboardViewController.h"
#import "CallViewController.h"
#import "AlarmViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (IBAction)itsBedtime:(id)sender {
    AlarmViewController *alarmView = [[AlarmViewController alloc] init];
    [self presentViewController:alarmView animated:YES completion:nil];
}

- (IBAction)makeACall:(id)sender {
    CallViewController *call = [[CallViewController alloc] init];
    [self presentViewController:call animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
