//
//  SleepViewController.h
//  VideoChat
//
//  Created by Ali Dinani on 2014-09-20.
//  Copyright (c) 2014 Ruslan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SleepViewController : UIViewController {
    NSTimer *timer;
}

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *alarmLabel;

@end
