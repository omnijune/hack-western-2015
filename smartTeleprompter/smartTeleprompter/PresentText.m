//
//  PresentText.m
//  smartTeleprompter
//
//  Created by Flora Zhang on 2015-03-28.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

#import "PresentText.h"

@interface PresentText ()

@end

@implementation PresentText

- (void)viewDidLoad {
    [super viewDidLoad];
    CGPoint bottomOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomOffset animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    float scrollDuration = 4.0;
    
    [UIView animateWithDuration:scrollDuration animations:^{
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
    }];
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