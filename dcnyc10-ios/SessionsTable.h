//
//  SessionsTable.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SessionsTable : UITableViewController <NSFetchedResultsControllerDelegate> {
    NSArray *sessions;
    NSFetchedResultsController *fetchedResultsController;
}

@property (nonatomic, retain) NSArray *sessions;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end


