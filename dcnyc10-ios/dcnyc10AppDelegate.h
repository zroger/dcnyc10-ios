//
//  dcnyc10AppDelegate.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface dcnyc10AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,RKObjectLoaderDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

- (void) initObjectManager;
- (void) demoReachability;
- (void) loadRemoteObjects;

@end
