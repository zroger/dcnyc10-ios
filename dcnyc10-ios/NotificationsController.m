//
//  NotificationsController.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NotificationsController.h"

@implementation NotificationsController

+ (void)scheduleNotificationForSession:(CodSession *)session
{    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"sessionNotifications"]) {
        return;
    }

    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil) {
        return;
    }
    
    int minutesBefore = 10;
    
    // DEBUG code.  set alert for +30 seconds.
    // localNotif.fireDate = [NSDate dateWithTimeIntervalSinceNow:(30)];
    
    localNotif.fireDate = [session.start dateByAddingTimeInterval:-(minutesBefore*60)];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.alertBody = [NSString stringWithFormat:@"%@ starts in %i minutes in room %@.", session.title, minutesBefore, session.room];
    
    localNotif.alertAction = NSLocalizedString(@"View Details", nil);
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    //    localNotif.applicationIconBadgeNumber = 1;
    
    localNotif.userInfo = [NSDictionary dictionaryWithObject:session.nid forKey:@"sessionId"];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
    [localNotif release];
}

+ (void)cancelNotificationForSession:(CodSession *)session 
{    
    NSArray *oldNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in oldNotifications) {
        if ([[notification.userInfo objectForKey:@"sessionId"] isEqualToNumber:session.nid]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            NSLog(@"notification cancelled for session %@", session.title);
        }
    }
}

+ (void) cancelAllSessionNotifications
{
    // The only notifications being set are session notifications.  If we start
    // using notifications for other things, this will need to be more robust.
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

+ (void) rescheduleAllSessionNotifications
{
    [self cancelAllSessionNotifications];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"favorite = %@ && start > %@", [NSNumber numberWithBool:YES], [NSDate dateWithTimeIntervalSinceNow:0]];
    NSArray *sessions = [CodSession objectsWithPredicate:predicate];
    for (CodSession *session in sessions) {
        [self scheduleNotificationForSession:session];
    }
}

@end
