//
//  dcnyc10AppDelegate.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "dcnyc10AppDelegate.h"

#import "SessionsTable.h"
#import "DashboardViewController.h"
#import "SessionDetail.h"

#import "CodScheduleItem.h"
#import "CodSession.h"
#import "CodSponsor.h"
#import "CodSpeaker.h"
#import "CodNews.h"
#import "TwitterMessage.h"
#import "TwitterUser.h"

#import <RestKit/CoreData/CoreData.h>

#import "TestFlight.h"

@implementation dcnyc10AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *appDefaults = [NSDictionary
                                 dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"sessionNotifications"];    
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    DashboardViewController *dashboard;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        dashboard = [[[DashboardViewController alloc] initWithNibName:@"DashboardViewController" bundle:nil] autorelease];
    } else {
        // TODO: iPad view.
        dashboard = [[[DashboardViewController alloc] initWithNibName:@"DashboardViewController" bundle:nil] autorelease];
    }

    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:dashboard] autorelease];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:61/255.0 green:82/255.0 blue:104/255.0 alpha:1.0];
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    [self initObjectManager];
    [self demoReachability];
    [self loadRemoteObjects];
    
#ifdef USE_TESTFLIGHT
    [TestFlight takeOff:@"e950ffa307d0514132a19056b73baebb_NDA4NDkyMDExLTExLTE0IDEwOjQ3OjUxLjQ4OTM2Mw "];
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void) initObjectManager {
//    RKObjectManager *manager = [RKObjectManager objectManagerWithBaseURL:@"http://dcnyc10.zroger.com/cod-api"];
    RKObjectManager *manager = [RKObjectManager objectManagerWithBaseURL:@"http://dcnyc10.dev:3000/cod-api"];
    manager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"MyApp.sqlite"];

    // Mapping for CodScheduleItem
    RKManagedObjectMapping* scheduleItemMapping = [RKManagedObjectMapping mappingForClass:[CodScheduleItem class]];
    [scheduleItemMapping mapAttributes:@"nid", @"title", @"uri",
        @"created", @"changed", @"accepted",
        @"body", @"room", @"start", @"end", nil];
    scheduleItemMapping.primaryKeyAttribute = @"nid";
    [[RKObjectManager sharedManager].mappingProvider setMapping:scheduleItemMapping forKeyPath:@"schedule_item"];
    
    // Mapping for CodSession
    RKManagedObjectMapping* sessionMapping = [RKManagedObjectMapping mappingForClass:[CodSession class]];
    [sessionMapping mapAttributes:@"nid", @"title", @"uri",
        @"created", @"changed", @"accepted",
        @"body", @"experience", @"track",
        @"room", @"capacity", @"start", @"end", nil];
    sessionMapping.primaryKeyAttribute = @"nid";
    [[RKObjectManager sharedManager].mappingProvider setMapping:sessionMapping forKeyPath:@"session"];

    [CodSponsor initObjectMapping];
    [CodSpeaker initObjectMapping];
    [CodNews initObjectMapping];
    [TwitterMessage initObjectMapping];


    RKObjectMapping *speakerMapping = [[RKObjectManager sharedManager].mappingProvider objectMappingForClass:[CodSpeaker class]];

    // Define the speakers relationship mapping
    [sessionMapping mapKeyPath:@"speakers" toRelationship:@"speakers" withMapping:speakerMapping];
}

- (void)loadRemoteObjects {
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/session" delegate:self]; 
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/sponsor" delegate:self]; 
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/news" delegate:self]; 
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    if ([objectLoader wasSentToResourcePath:@"/session"]) {
        // Introspect the resource path
        //NSLog(@"Nice! We loaded the following sessions: %@", objects);
    } 
}
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    // Note that failures here can be at the _application_ level in addition to transport
}

- (void)demoReachability {
    // Check if the network is available
//    [[RKClient sharedClient] isNetworkReachable];
//    // Register for changes in network availability
//    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(reachabilityDidChange:) name:RKReachabilityDidChangeNotification object:nil];
}

- (void)reachabilityDidChange:(NSNotification *)notification {
    RKReachabilityObserver* observer = (RKReachabilityObserver *) [notification object];
    
    RKReachabilityNetworkStatus status = [observer networkStatus];
    if (RKReachabilityNotReachable == status) {
        NSLog(@"No network access!");
    } else if (RKReachabilityReachableViaWiFi == status) {
         NSLog(@"Online via WiFi!");
    } else if (RKReachabilityReachableViaWWAN == status) {
         NSLog(@"Online via Edge or 3G!");
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    if (application.applicationState == UIApplicationStateInactive ) {
        [self gotoSessionDetailwithSessionId:[notification.userInfo objectForKey:@"sessionId"]];
    }
    
    if(application.applicationState == UIApplicationStateActive ) { 
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Active" message:notification.alertBody delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"View Session", nil] autorelease];
        
        // Store session id in the alert view's tag.  This seems like a hack,
        // but I'm not sure how else to pass a variable into the delegate.
        alert.tag = [[notification.userInfo objectForKey:@"sessionId"] integerValue];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button clicked: %i", buttonIndex);
    if (buttonIndex == 1) {
        [self gotoSessionDetailwithSessionId:[NSNumber numberWithInt:alertView.tag]];
    }
}

- (void)gotoSessionDetail:(CodSession *)session
{
    // Navigation logic may go here. Create and push another view controller.
    SessionDetail *detailViewController = [[SessionDetail alloc] initWithNibName:@"SessionDetail" bundle:nil];
    
    // Pass the selected object to the new view controller.
    detailViewController.session = session;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

- (void)gotoSessionDetailwithSessionId:(NSNumber *)sessionId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nid = %@", sessionId];
    CodSession *session = [CodSession objectWithPredicate:predicate];
    [self gotoSessionDetail:session];
}

@end
