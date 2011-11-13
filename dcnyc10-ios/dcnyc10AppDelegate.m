//
//  dcnyc10AppDelegate.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "dcnyc10AppDelegate.h"

#import "dcnyc10SecondViewController.h"

#import "SessionsTable.h"
#import "DashboardViewController.h"

#import "CodSession.h"
#import "CodSponsor.h"

#import <RestKit/CoreData/CoreData.h>

@implementation dcnyc10AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize navigationController = _navigationController;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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

    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    [self initObjectManager];
    [self demoReachability];
    [self loadRemoteObjects];
    
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

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

- (void) initObjectManager {
    RKObjectManager *manager = [RKObjectManager objectManagerWithBaseURL:@"http://dcnyc10.dev:3000/cod-api"];
    RKManagedObjectStore* objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"MyApp.sqlite"];
    manager.objectStore = objectStore;

    [CodSession initObjectMapping];
    [CodSponsor initObjectMapping];
}

- (void)loadRemoteObjects {
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/session" delegate:self]; 
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/sponsor" delegate:self]; 
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    if ([objectLoader wasSentToResourcePath:@"/session"]) {
        // Introspect the resource path
        //NSLog(@"Nice! We loaded the following sessions: %@", objects);
    } 
}
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    // Note that failures here can be at the _application_ level in addition to transport
    NSLog(@"Rats! Failed to load objects: %@", [error localizedDescription]); 
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


@end
