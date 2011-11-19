//
//  dcnyc10AppDelegate.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "CodSession.h"

@interface dcnyc10AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,RKObjectLoaderDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *navigationController;

- (void) initObjectManager;
- (void) demoReachability;
- (void) loadRemoteObjects;

- (void)scheduleNotificationForSession:(CodSession *)session interval:(int)minutesBefore;
- (void)cancelNotificationForSession:(CodSession *)session;

- (void)gotoSessionDetail:(CodSession *)session;
- (void)gotoSessionDetailwithSessionId:(NSNumber *)sessionId;

@end
