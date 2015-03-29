//
//  PresentText.h
//  smartTeleprompter
//
//  Created by Flora Zhang on 2015-03-28.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeechTranscript.h"



@interface PresentText : UIViewController
{
    IBOutlet UILabel *TimerDisplay;
    NSTimer *Timer;
}

@property (nonatomic, retain) IBOutlet UITextView* textView;
@property (nonatomic, retain) IBOutlet UILabel* speechTranscriptBig;
@property (nonatomic, assign) int counter;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic) SpeechTranscript * speech;
//@property (nonatomic, assign) IBOutlet UILabel *TimerDisplay;
//@property (nonatomic, retain) NSTimer *Timer;

-(IBAction)unwindToList:(UIStoryboardSegue *)segue;
-(void)TimerCount;
-(IBAction)Start:(id)sender;
//-(IBAction)Pause:(id)sender;


@end
