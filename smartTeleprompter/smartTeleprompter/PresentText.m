//
//  PresentText.m
//  smartTeleprompter
//
//  Created by Flora Zhang on 2015-03-28.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

#import "PresentText.h"
#import "AddText.h"
#import <QuartzCore/QuartzCore.h>
#import "SpeechTranscript.h"
#import "AppDelegate.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>

@interface PresentText ()

@end

const unsigned char SpeechKitApplicationKey[] = {0xa9, 0x98, 0x96, 0x0e, 0x28, 0x6c, 0xfb, 0x56, 0xf9, 0xed, 0x25, 0x84, 0xd2, 0x1a, 0x02, 0xfc, 0x67, 0xe0, 0xea, 0x26, 0xbd, 0x56, 0x32, 0xa5, 0xf3, 0x3f, 0x72, 0xb2, 0xf1, 0x42, 0x24, 0x9a, 0xda, 0xba, 0xa9, 0x02, 0x26, 0xa4, 0x58, 0x20, 0x92, 0x7e, 0xa4, 0x64, 0x98, 0xa6, 0x60, 0xff, 0x86, 0x4a, 0x25, 0x43, 0xa1, 0x58, 0xe9, 0x94, 0x97, 0x5b, 0x46, 0x88, 0x9d, 0x6a, 0x23, 0x78};

@implementation PresentText

- (void)TimerCount{
    paused = false;
    countNumber = countNumber +1;
    TimerDisplay.text = [NSString stringWithFormat:@"%i", countNumber];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.appDelegate setupSpeechKitConnection];
    paused = true;
    self.highlightOccurrence = 0;
    self.lastWord = [[NSString alloc] init];
    self.spokenText.returnKeyType = UIReturnKeySearch;
    self.blockBeginIndex =0;
    self.blockEndIndex =[self.speech.transcript length]-1;
    self.counterIncrement = 2;
    self.highlightBlock = [[NSMutableAttributedString alloc] initWithString:self.speech.transcript];
    NSRange stringR =  NSMakeRange(0, [self.speech.transcript length]);
    [self.highlightBlock addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica Neue" size:26.0] range:stringR];
    [self makeTextBlock];
    
}

- (void) slowScrollText{
    if(self.counter<=self.bottom){
        if (paused==false){
            [self.textView setContentOffset:CGPointMake(0,self.counter) animated:NO];
            self.counter+=self.counterIncrement;
        }
        [self performSelector:@selector(slowScrollText) withObject:nil afterDelay:.20];
    }
}

-(void) makeTextBlock{
    NSRange stringR;
    BOOL beginFound = false;
    [self.highlightBlock beginEditing];
    if(self.highlightOccurrence != 0){
        stringR =  NSMakeRange(self.blockBeginIndex, self.blockEndIndex - self.blockBeginIndex + 1);
        [self.highlightBlock removeAttribute:NSBackgroundColorAttributeName range:stringR];
        for(long i = self.blockEndIndex+2; i<[self.textView.attributedText length]; i++){
            NSLog(@"%@",[self.highlightBlock.string substringWithRange:NSMakeRange(i, 1)]);
            
            if(![[self.highlightBlock.string substringWithRange:NSMakeRange(i, 1)]  isEqual: @" "] &&
               ![[self.highlightBlock.string substringWithRange:NSMakeRange(i, 1)]  isEqual: @"\n"] &&
               !beginFound){
                self.blockBeginIndex =i;
                beginFound = true;
            }
            
            if([[self.highlightBlock.string substringWithRange:NSMakeRange(i, 1)]  isEqual: @"."] ||
               [[self.highlightBlock.string substringWithRange:NSMakeRange(i, 1)]  isEqual: @"?"] ||
               [[self.highlightBlock.string substringWithRange:NSMakeRange(i, 1)]  isEqual: @"!"]){
                self.blockEndIndex = i;
                break;
            }
        }
    }else{
        for(long i = self.blockBeginIndex; i<[self.speech.transcript length]; i++){
            if([[self.speech.transcript substringWithRange:NSMakeRange(i, 1)]  isEqual: @"."] ||
               [[self.speech.transcript substringWithRange:NSMakeRange(i, 1)]  isEqual: @"?"] ||
               [[self.speech.transcript substringWithRange:NSMakeRange(i, 1)]  isEqual: @"!"]){
                self.blockEndIndex = i;
                break;
            }
        }
        self.highlightOccurrence = 1;
    }
    
    stringR =  NSMakeRange(self.blockBeginIndex, self.blockEndIndex - self.blockBeginIndex + 1);
    [self.highlightBlock addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:stringR];
    [self.highlightBlock endEditing];
    self.lastWord = [[self.highlightBlock.string substringWithRange:stringR] componentsSeparatedByString:@" "].lastObject;
    self.lastWord = [[self.lastWord componentsSeparatedByString:@"."].firstObject stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSLog(@"last word: %@", self.lastWord);
    self.textView.attributedText = self.highlightBlock;
}


- (void) viewDidAppear:(BOOL) animated {
    [super viewDidAppear:animated];
    self.bottom =[self.textView contentSize].height+200;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Start:(id)sender{
    if (paused == true) {
//        paused = false;
        Timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerCount) userInfo:nil repeats:YES];

        [self startListening];
    } else {
        [Timer invalidate];
        paused = true;
    }
    
}
//-(IBAction)Pause:(id)sender{
//    [Timer invalidate];
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

# pragma mark - SKRecognizer Delegate Methods


- (void) startListening {
    
    self.PlayButton.selected = !self.PlayButton.isSelected;
    
    // This will initialize a new speech recognizer instance
    if (self.PlayButton.isSelected) {
    
//    while (!paused) {
        self.voiceSearch = [[SKRecognizer alloc] initWithType:SKSearchRecognizerType
                                                    detection:SKShortEndOfSpeechDetection
                                                     language:@"en_US"
                                                     delegate:self];
    }
    
    // This will stop existing speech recognizer processes
    else {
        if (self.voiceSearch) {
            [self.voiceSearch stopRecording];
            [self.voiceSearch cancel];
        }
    }
}


- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer {
//    self.someLabel.text = @"Listening...";
}

- (void)recognizerDidFinishRecording:(SKRecognizer *)recognizer {
//    self.someLabel.text = @"Done Listening...";
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results {
    long numOfResults = [results.results count];
    
    if (numOfResults > 0) {
        // update the text of text field with best result from SpeechKit
        self.spokenText.text = [results firstResult];
        NSLog(@"print word %@", [self.spokenText.text lowercaseString]);
        if ([[self.spokenText.text lowercaseString] rangeOfString:self.lastWord].location != NSNotFound) {
            NSLog(@"substring match");
            [self makeTextBlock];
        }
        [self slowScrollText];
    }
    
    self.PlayButton.selected = !self.PlayButton.isSelected;
    
    if (self.voiceSearch) {
        [self.voiceSearch cancel];
    }
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion {
    self.PlayButton.selected = NO;
//    self.ListenStatus.text = @"Connection Error";
//    self.activityIndicator.hidden = YES;
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


@end