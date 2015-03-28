//
//  ViewController.m
//  smartTeleprompter
//
//  Created by Kevin Chen on 2015-03-28.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

#import "ViewController.h"
#import "SpeechTranscript.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTranscript = [[SpeechTranscript alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) insertString: (NSString *) insertingString intoTextView: (UITextView *) textView
{
    NSRange range = textView.selectedRange;
    NSString * firstHalfString = [textView.text substringToIndex:range.location];
    NSString * secondHalfString = [textView.text substringFromIndex: range.location];
    textView.scrollEnabled = NO;  // turn off scrolling or you'll get dizzy ... I promise
    
    textView.text = [NSString stringWithFormat: @"%@%@%@",
                     firstHalfString,
                     insertingString,
                     secondHalfString];
    range.location += [insertingString length];
    textView.selectedRange = range;
    textView.scrollEnabled = YES;  // turn scrolling back on.
    self.myTranscript.transcript = textView.text;
}


@end
