//
//  ScheduleItemTableViewCell.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ScheduleItemTableViewCell.h"
#import "TestFlight.h"
#import "NotificationsController.h"

@implementation ScheduleItemTableViewCell

@synthesize scheduleItem;
@synthesize titleLabel;
@synthesize timeLabel;
@synthesize roomLabel;
@synthesize starButton;

- (void)dealloc
{
    [scheduleItem release];
    [titleLabel release];
    [timeLabel release];
    [roomLabel release];
    [starButton release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void) setScheduleItem:(CodScheduleItem *)newScheduleItem
{
    if (newScheduleItem != scheduleItem)
    {
        [newScheduleItem retain];
        [scheduleItem release];
        scheduleItem = newScheduleItem;
        
        titleLabel.text = scheduleItem.title;
        roomLabel.text = scheduleItem.room;
                
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
        [formatter setDateFormat:@"h:mma"];
        timeLabel.text = [formatter stringFromDate:scheduleItem.start];
        
        if ([scheduleItem.favorite isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            [starButton setImage:[UIImage imageNamed:@"btn_favorite-active.png"] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)toggleFavorite:(id)sender {
    if ([scheduleItem.favorite isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [scheduleItem setFavorite:[NSNumber numberWithBool:NO]];
        [starButton setImage:[UIImage imageNamed:@"btn_favorite-inactive.png"] forState:UIControlStateNormal];
        [NotificationsController cancelNotificationForSession:scheduleItem];
    }
    else {
        [scheduleItem setFavorite:[NSNumber numberWithBool:YES]];
        [starButton setImage:[UIImage imageNamed:@"btn_favorite-active.png"] forState:UIControlStateNormal];
        [NotificationsController scheduleNotificationForSession:scheduleItem];
    }
    
    NSError *error = nil;
    [scheduleItem.managedObjectContext save:&error];
    
#ifdef USE_TESTFLIGHT
    [TestFlight passCheckpoint:@"Favorite toggled from table cell"];
#endif
}

@end
