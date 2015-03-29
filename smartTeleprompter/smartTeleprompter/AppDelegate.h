//
//  AppDelegate.h
//  smartTeleprompter
//
//  Created by Kevin Chen on 2015-03-28.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpeechKit/SpeechKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//- (void)updateCurrentLocation;
//- (void)stopUpdatingCurrentLocation;
- (void)setupSpeechKitConnection;


@end

