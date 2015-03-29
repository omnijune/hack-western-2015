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

@interface AddText ()<UITextViewDelegate>

// MY CODE



@end

@implementation AddText

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.layer.borderWidth = 1.0f;
    self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.textView.layer.cornerRadius = 8;
    self.textView.textContainerInset = UIEdgeInsetsMake(7, 5, 7, 5);
    self.textView.delegate = self;
    self.textView.text = @"Paste your speech here.";
    self.textView.textColor = [UIColor lightGrayColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MY CODE
- (IBAction)unwindToAdd:(UIStoryboardSegue *)segue {
//    countNumber = 0;
//    paused = TRUE;
}

- (void)saveText: (UITextView *) textView
{}

// for the placeholder text for UItextview

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Paste your speech here."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Paste your speech here.";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

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


- (IBAction)Clear:(UIButton *)sender {
    self.textView.text=@"";
}
@end
