//
//  AddText.m
//  smartTeleprompter
//
//  Created by Flora Zhang on 2015-03-28.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

#import "AddText.h"
#import "SpeechTranscript.h"
#import "PresentText.h"

@interface AddText ()

// MY CODE



@end

@implementation AddText

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MY CODE
- (IBAction)unwindToAdd:(UIStoryboardSegue *)segue {
    
}

- (void)saveText: (UITextView *) textView
{}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender != self.saveText) return;
    PresentText *dest = [segue destinationViewController];
    dest.speech = [[SpeechTranscript alloc] init];
    dest.speech.transcript = self.textView.text;
    
    NSLog(@"%@",self.myTranscript.transcript);
    NSLog(@"%@",dest.speech.transcript);
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
