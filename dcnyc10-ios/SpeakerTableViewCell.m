//
//  SpeakerTableViewCell.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SpeakerTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation SpeakerTableViewCell

@synthesize speaker;
@synthesize textLabel;
@synthesize detailTextLabel;
@synthesize imageView;

- (void) dealloc
{
    [speaker release];
    [textLabel release];
    [detailTextLabel release];
    [imageView release];
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

-(void) setSpeaker:(CodSpeaker *)newSpeaker
{
    if (newSpeaker != speaker)
    {
        [newSpeaker retain];
        [speaker release];
        speaker = newSpeaker;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        textLabel.text = [NSString stringWithFormat:@"%@ %@", speaker.first_name, speaker.last_name];
        detailTextLabel.text = speaker.organization;
        
        [imageView setImageWithURL:[NSURL URLWithString:speaker.picture]
                       placeholderImage:[UIImage imageNamed:@"Contact.png"]];

    }
}

@end
