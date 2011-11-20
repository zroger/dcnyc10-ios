//
//  NotificationsController.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodSession.h"

@interface NotificationsController : NSObject

+ (void)scheduleNotificationForSession:(CodSession *)session;
+ (void)cancelNotificationForSession:(CodSession *)session;

+ (void) cancelAllSessionNotifications;
+ (void) rescheduleAllSessionNotifications;

@end
