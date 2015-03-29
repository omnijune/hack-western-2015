//
//  PresentText.m
//  smartTeleprompter
//
//  Created by Flora Zhang on 2015-03-28.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

#import "PresentText.h"
#import "AddText.h"

int countNumber;
BOOL paused = TRUE;


@interface PresentText ()

@end

@implementation PresentText

-(void)TimerCount{
    countNumber = countNumber +1;
    TimerDisplay.text = [NSString stringWithFormat:@"%i", countNumber];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    //self.countNumber = 0;
    //self.paused = TRUE;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.speech.transcript;
}

-(void) slowScrollText{
    if(self.counter<=self.bottom){
        [self.textView setContentOffset:CGPointMake(0,self.counter) animated:NO];
        self.counter+=5;
        [self performSelector:@selector(slowScrollText) withObject:nil afterDelay:.1];
    }
}

-(IBAction)Start:(id)sender{
    NSLog(@";askjdklgalksndfa");
    Timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerCount) userInfo:nil repeats:YES];
}
//-(IBAction)Pause:(id)sender{
//    [Timer invalidate];
//    
//}


-(void) viewDidAppear:(BOOL) animated {
    [super viewDidAppear:animated];
    self.bottom =[self.textView contentSize].height+200;

    [self slowScrollText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end