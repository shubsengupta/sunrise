//
//  SleepViewController.m
//  VideoChat
//
//  Created by Ali Dinani on 2014-09-20.
//  Copyright (c) 2014 Ruslan. All rights reserved.
//

#import "SleepViewController.h"
#import "AlarmViewController.h"

@interface SleepViewController ()

@end

@implementation SleepViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateTime];
    [self startTimer: timer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)awake:(id)sender {
    AlarmViewController *alarmView = [[AlarmViewController alloc] init];
    [self presentViewController:alarmView animated:YES completion:nil];
}

- (IBAction)updateTime {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    self.timeLabel.text = currentTime;
}

- (void)startTimer:(NSTimer *)theTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
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
