//
//  AddText.h
//  smartTeleprompter
//
//  Created by Flora Zhang on 2015-03-28.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeechTranscript.h"

@interface AddText : UIViewController

@property (nonatomic) SpeechTranscript* myTranscript;

// MY CODE
- (IBAction)unwindToAdd:(UIStoryboardSegue *)segue;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *saveText;


- (IBAction)Clear:(UIButton *)sender;
@end
