//
//  SponsorsTableViewController.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>
#import "PullRefreshTableViewController.h"

@interface SponsorsTableViewController : PullRefreshTableViewController <NSFetchedResultsControllerDelegate, RKObjectLoaderDelegate> 
{
    NSFetchedResultsController *fetchedResultsController;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void)dismissRefreshError;

@end
