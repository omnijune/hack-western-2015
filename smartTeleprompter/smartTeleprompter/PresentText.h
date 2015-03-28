//
//  PresentText.h
//  smartTeleprompter
//
//  Created by Flora Zhang on 2015-03-28.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentText : UIViewController
@property (nonatomic, retain) IBOutlet UITextView* textView;
@property (nonatomic, retain) IBOutlet UILabel* speechTranscriptBig;
@property (nonatomic, assign) int counter;
@property (nonatomic, assign) CGFloat bottom;
@end
