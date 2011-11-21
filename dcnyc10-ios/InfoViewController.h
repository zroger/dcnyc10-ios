//
//  InfoViewController.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UILabel *versionLabel;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *linkTitles;
@property (nonatomic, retain) NSArray *linkUrls;

@end
