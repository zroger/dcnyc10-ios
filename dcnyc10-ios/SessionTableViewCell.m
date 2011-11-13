//
//  SessionTableViewCell.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SessionTableViewCell.h"

@implementation SessionTableViewCell

@synthesize session;

@synthesize titleLabel;
@synthesize speakerLabel;
@synthesize timeLabel;
@synthesize roomLabel;
@synthesize trackLabel;

- (void)dealloc
{
    [session release];
    [titleLabel release];
    [speakerLabel release];
    [timeLabel release];
    [roomLabel release];
    [trackLabel release];

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
        trackLabel.text = session.track;
    }
}

@end
