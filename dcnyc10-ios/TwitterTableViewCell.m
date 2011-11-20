//
//  TwitterTableViewCell.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TwitterUser.h"

@implementation TwitterTableViewCell

@synthesize tweet;
@synthesize textLabel;
@synthesize detailTextLabel;
@synthesize imageView;

- (void) dealloc
{
    [tweet release];
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

-(void) setTweet:(TwitterMessage *)newTweet
{
    if (newTweet != tweet)
    {
        [newTweet retain];
        [tweet release];
        tweet = newTweet;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        textLabel.text = tweet.text;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
        [dateFormatter setDateFormat:@"EEEE MMMM d, YYYY"];
        
        detailTextLabel.text = [dateFormatter stringFromDate:tweet.created_at];        
        [dateFormatter release];
        
        [imageView setImageWithURL:[NSURL URLWithString:tweet.user.profile_image_url]
                  placeholderImage:[UIImage imageNamed:@"Contact.png"]];
    }
}

@end
