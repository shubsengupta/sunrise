//
//  SleepingViewController.m
//  VideoChat
//
//  Created by Ali Dinani on 2014-09-20.
//  Copyright (c) 2014 Ruslan. All rights reserved.
//

#import "SleepingViewController.h"
#import "MainViewController.h"
#import "DashboardViewController.h"
#import "AppDelegate.h"

@interface SleepingViewController ()

@end

@implementation SleepingViewController

@synthesize opponentID;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAlarmText];
    [self updateTime];
    [self startTimer: timer];
    hangUpButton.hidden = true;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // Start sending chat presence
    [QBChat instance].delegate = self;
    [NSTimer scheduledTimerWithTimeInterval:30 target:[QBChat instance] selector:@selector(sendPresence) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateAlarmText {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    NSString *dateString = [outputFormatter stringFromDate: appDelegate.alarmDate];
    
    
    alarmLabel.text = [NSString stringWithFormat: @"ALARM AROUND %@", dateString];
}

- (void)updateTime {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    timeLabel.text = currentTime;
}

- (void)startTimer:(NSTimer *)theTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (IBAction)hangUp:(id)sender {
    [self.videoChat finishCall];
    myVideoView.hidden = YES;
    
    opponentVideoView.layer.contents = (id)[[UIImage imageNamed:@"blackpx.png"] CGImage];
    opponentVideoView.image = [UIImage imageNamed:@"blackpx.png"];
    
    [[QBChat instance] unregisterVideoChatInstance:self.videoChat];
    self.videoChat = nil;
    
    DashboardViewController *dash = [[DashboardViewController alloc] init];
    [self presentViewController:dash animated:YES completion:nil];
}

- (void)accept{
    NSLog(@"accept");
    
    // Setup video chat
    if(self.videoChat == nil){
        self.videoChat = [[QBChat instance] createAndRegisterVideoChatInstanceWithSessionID:sessionID];
        self.videoChat.viewToRenderOpponentVideoStream = opponentVideoView;
        self.videoChat.viewToRenderOwnVideoStream = myVideoView;
    }
    
    // Set Audio & Video output
    self.videoChat.useHeadphone = false;
    self.videoChat.useBackCamera = false;
    alarmLabel.hidden = YES;
    timeLabel.textColor = [UIColor greenColor];
    
    // Accept call
    [self.videoChat acceptCallWithOpponentID:videoChatOpponentID conferenceType:videoChatConferenceType];
    
    opponentVideoView.layer.borderWidth = 0;
    
    myVideoView.hidden = NO;
    hangUpButton.hidden = NO;
    
    ringingPlayer = nil;
}

#pragma mark -
#pragma mark AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    ringingPlayer = nil;
}


#pragma mark -
#pragma mark QBChatDelegate
//
// VideoChat delegate

-(void) chatDidReceiveCallRequestFromUser:(NSUInteger)userID withSessionID:(NSString *)_sessionID conferenceType:(enum QBVideoChatConferenceType)conferenceType{
    NSLog(@"chatDidReceiveCallRequestFromUser %lu", (unsigned long)userID);
    
    // save  opponent data
    videoChatOpponentID = userID;
    videoChatConferenceType = conferenceType;
    sessionID = _sessionID;
    
    [self accept];
}

-(void) chatCallUserDidNotAnswer:(NSUInteger)userID{
    NSLog(@"chatCallUserDidNotAnswer %lu", (unsigned long)userID);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QuickBlox VideoChat" message:@"User isn't answering. Please try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

-(void) chatCallDidRejectByUser:(NSUInteger)userID{
    NSLog(@"chatCallDidRejectByUser %lu", (unsigned long)userID);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QuickBlox VideoChat" message:@"User has rejected your call." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

-(void) chatCallDidAcceptByUser:(NSUInteger)userID{
    NSLog(@"chatCallDidAcceptByUser %lu", (unsigned long)userID);
    
    opponentVideoView.layer.borderWidth = 0;
    
    myVideoView.hidden = NO;
}

-(void) chatCallDidStopByUser:(NSUInteger)userID status:(NSString *)status{
    NSLog(@"chatCallDidStopByUser %lu purpose %@", (unsigned long)userID, status);
    
    if([status isEqualToString:kStopVideoChatCallStatus_OpponentDidNotAnswer]){
        
        self.callAlert.delegate = nil;
        [self.callAlert dismissWithClickedButtonIndex:0 animated:YES];
        self.callAlert = nil;
        
        ringingPlayer = nil;
        
    }else{
        myVideoView.hidden = YES;
        opponentVideoView.layer.contents = (id)[[UIImage imageNamed:@"person.png"] CGImage];
        opponentVideoView.layer.borderWidth = 1;
    }

    // release video chat
    //
    [[QBChat instance] unregisterVideoChatInstance:self.videoChat];
    self.videoChat = nil;
    
    DashboardViewController *dash = [[DashboardViewController alloc] init];
    [self presentViewController:dash animated:YES completion:nil];
}

- (void)chatCallDidStartWithUser:(NSUInteger)userID sessionID:(NSString *)sessionID{
}

- (void)didStartUseTURNForVideoChat{
    //    NSLog(@"_____TURN_____TURN_____");
}
@end