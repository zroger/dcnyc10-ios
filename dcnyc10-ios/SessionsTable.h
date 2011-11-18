//
//  SessionsTable.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>
#import "PullRefreshTableViewController.h"

@interface SessionsTable : PullRefreshTableViewController <NSFetchedResultsControllerDelegate, RKObjectLoaderDelegate> {
    NSArray *sessions;
    NSFetchedResultsController *fetchedResultsController;
}

@property (nonatomic, retain) NSArray *sessions;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *refreshButton;

- (IBAction)refreshData:(id)sender;

@end


