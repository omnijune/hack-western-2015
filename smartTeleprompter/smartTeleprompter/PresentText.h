//
//  PresentText.h
//  smartTeleprompter
//
//  Created by Flora Zhang on 2015-03-28.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeechTranscript.h"
#import "AppDelegate.h"
#import <SpeechKit/SpeechKit.h>

int countNumber;
BOOL paused = true;

@interface PresentText : UIViewController
{
    IBOutlet UILabel *TimerDisplay;
    NSTimer *Timer;
}

@interface PresentText : UIViewController <UITextFieldDelegate, SpeechKitDelegate, SKRecognizerDelegate>
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) SKRecognizer* voiceSearch;

@property (nonatomic, retain) IBOutlet UITextView* textView;
@property (nonatomic, retain) IBOutlet UILabel* speechTranscriptBig;
@property (nonatomic, assign) int counter;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic) SpeechTranscript * speech;
//@property (nonatomic, assign) IBOutlet UILabel *TimerDisplay;
//@property (nonatomic, retain) NSTimer *Timer;

-(IBAction)unwindToList:(UIStoryboardSegue *)segue;

@property (weak, nonatomic) IBOutlet UITextField *spokenText;
@property (weak, nonatomic) IBOutlet UIButton *ListenButton;
- (IBAction)startListening:(id)sender;


@end

