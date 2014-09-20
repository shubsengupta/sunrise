//
//  CallViewController.h
//  VideoChat
//
//  Created by Ali Dinani on 2014-09-20.
//  Copyright (c) 2014 Ruslan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallViewController : UIViewController {
    NSTimer *timer;
}
@property (strong, nonatomic) IBOutlet UILabel *countDown;
    
@end
