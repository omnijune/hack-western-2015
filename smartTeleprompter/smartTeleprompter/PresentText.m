//
//  PresentText.m
//  smartTeleprompter
//
//  Created by Flora Zhang on 2015-03-28.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

#import "PresentText.h"
#import "AddText.h"


@interface PresentText ()

@end

@implementation PresentText

-(void)TimerCount{
    paused = false;
    countNumber = countNumber +1;
    TimerDisplay.text = [NSString stringWithFormat:@"%i", countNumber];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {

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
    if (paused == true){
        NSLog(@"alsfjasdjfaldfjas");
        Timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerCount) userInfo:nil repeats:YES];}
    else {
        [Timer invalidate];
        paused = true;
    }
}


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