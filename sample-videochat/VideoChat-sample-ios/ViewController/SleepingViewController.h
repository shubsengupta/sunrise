//
//  SleepingViewController.h
//  VideoChat
//
//  Created by Ali Dinani on 2014-09-20.
//  Copyright (c) 2014 Ruslan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SleepingViewController : UIViewController <QBChatDelegate, AVAudioPlayerDelegate, UIAlertViewDelegate>{
    IBOutlet UIImageView *opponentVideoView;
    IBOutlet UIImageView *myVideoView;
    
    AVAudioPlayer *ringingPlayer;

    NSUInteger videoChatOpponentID;
    enum QBVideoChatConferenceType videoChatConferenceType;
    NSString *sessionID;
}

@property (strong) NSNumber *opponentID;
@property (strong) QBVideoChat *videoChat;
@property (strong) UIAlertView *callAlert;

- (void)accept;

@end
