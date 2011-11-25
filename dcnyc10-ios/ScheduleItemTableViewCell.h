//
//  ScheduleItemTableViewCell.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodScheduleItem.h"

@interface ScheduleItemTableViewCell : UITableViewCell

@property (nonatomic, retain) CodScheduleItem *scheduleItem;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *roomLabel;
@property (nonatomic, retain) IBOutlet UIButton *starButton;

- (IBAction)toggleFavorite:(id)sender;


@end
