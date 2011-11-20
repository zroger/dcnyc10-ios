//
//  SessionTableViewCell.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SessionTableViewCell.h"
#import "CodSpeaker.h"
#import "MREntitiesConverter.h"
#import "TestFlight.h"
#import "NotificationsController.h"

@implementation SessionTableViewCell

@synthesize session;

@synthesize titleLabel;
@synthesize speakerLabel;
@synthesize timeLabel;
@synthesize roomLabel;
@synthesize trackLabel;
@synthesize starButton;

- (void)dealloc
{
    [session release];
    [titleLabel release];
    [speakerLabel release];
    [timeLabel release];
    [roomLabel release];
    [trackLabel release];
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

-(void) setSession:(CodSession *)newSession
{
    if (newSession != session)
    {
        [newSession retain];
        [session release];
        session = newSession;

        titleLabel.text = session.title;
        roomLabel.text = session.room;
        
        // Track
        MREntitiesConverter *converter = [[[MREntitiesConverter alloc] init] autorelease];
        trackLabel.text = [converter convertEntiesInString:session.track];

        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
        [formatter setDateFormat:@"h:mma"];
        timeLabel.text = [formatter stringFromDate:session.start];

        NSArray *speakersArray = [session.speakers allObjects];
        CodSpeaker *firstSpeaker = [speakersArray objectAtIndex:0];

        if ([speakersArray count] == 1) {
            speakerLabel.text = [NSString stringWithFormat:@"%@ %@", firstSpeaker.first_name, firstSpeaker.last_name];
        }
        else if ([speakersArray count] == 2) {
            CodSpeaker *secondSpeaker = [speakersArray objectAtIndex:1];
            speakerLabel.text = [NSString stringWithFormat:@"%@ %@ and %@ %@", firstSpeaker.first_name, firstSpeaker.last_name, secondSpeaker.first_name, secondSpeaker.last_name];
        }
        else {
            speakerLabel.text = [NSString stringWithFormat:@"%@ %@ and %d others", firstSpeaker.first_name, firstSpeaker.last_name, [speakersArray count] - 1];
        }
        
        if ([session.favorite isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            [starButton setImage:[UIImage imageNamed:@"btn_favorite-active.png"] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)toggleFavorite:(id)sender {
    if ([session.favorite isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [session setFavorite:[NSNumber numberWithBool:NO]];
        [starButton setImage:[UIImage imageNamed:@"btn_favorite-inactive.png"] forState:UIControlStateNormal];
        [NotificationsController cancelNotificationForSession:session];
    }
    else {
        [session setFavorite:[NSNumber numberWithBool:YES]];
        [starButton setImage:[UIImage imageNamed:@"btn_favorite-active.png"] forState:UIControlStateNormal];
        [NotificationsController scheduleNotificationForSession:session];
    }
    
    NSError *error = nil;
    [session.managedObjectContext save:&error];
    
    [TestFlight passCheckpoint:@"Favorite toggled from table cell"];
}

@end
