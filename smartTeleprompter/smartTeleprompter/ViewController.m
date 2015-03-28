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

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSString *theText = textView.text;
    if (![theText isEqualToString:@""]) {
        self.myTranscript.transcript = theText;
    }
}

@end
