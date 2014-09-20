//
//  CallViewController.m
//  VideoChat
//
//  Created by Ali Dinani on 2014-09-20.
//  Copyright (c) 2014 Ruslan. All rights reserved.
//

#import "CallViewController.h"
#import "MainViewController.h"

@interface CallViewController ()
@end

@implementation CallViewController

int secondsLeft;

- (void)viewDidLoad {
    [super viewDidLoad];
    secondsLeft = 5;
    [self countdownTimer: timer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTimer {
    if (secondsLeft > 1){
        secondsLeft--;
        self.countDown.text = [NSString stringWithFormat:@"%2d", secondsLeft];
    } else {
        MainViewController *main = [[MainViewController alloc] init];
        [self presentViewController:main animated:YES completion:nil];
    }
}

- (void)countdownTimer:(NSTimer *)theTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
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
