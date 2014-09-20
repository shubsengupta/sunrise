//
//  AlarmViewController.m
//  VideoChat
//
//  Created by Ali Dinani on 2014-09-20.
//  Copyright (c) 2014 Ruslan. All rights reserved.
//

#import "AlarmViewController.h"
#import "SleepingViewController.h"
#import "AppDelegate.h"

@interface AlarmViewController ()
@property (strong, nonatomic) IBOutlet UIDatePicker *alarmTime;

@end

@implementation AlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setAlarm:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SleepingViewController *sleepView = [[SleepingViewController alloc] init];
    appDelegate.alarmDate = self.alarmTime.date;
    [self presentViewController:sleepView animated:YES completion:nil];
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
