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
#import "NSAttributedString+Attributes.h"
#import "UILabel+DynamicHeight.h"

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
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        
        NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:tweet.text];
        [attrStr setFont:[UIFont systemFontOfSize:14.0]];
        textLabel.extendBottomToFit = TRUE;
        textLabel.linkColor = [UIColor colorWithRed:194/255.0 green:71/255.0 blue:33/255.0 alpha:1.0];
        textLabel.attributedText = attrStr;

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
        [dateFormatter setDateFormat:@"EEEE MMMM d, YYYY h:mm a"];
        
        detailTextLabel.text = [dateFormatter stringFromDate:tweet.created_at];        
        [dateFormatter release];
        
        [imageView setImageWithURL:[NSURL URLWithString:tweet.user.profile_image_url]
                  placeholderImage:[UIImage imageNamed:@"Contact.png"]];
        
        [self doLayout];
    }
}

- (void) doLayout
{
    CGRect frame;

    frame = self.frame;
    frame.size.height = textLabel.frame.size.height + 30.0;
    self.frame = frame;
}

+ (CGFloat) heightForCellWithString:(NSString *)string andWidth:(CGFloat)width
{
    NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:string];
    [attrStr setFont:[UIFont systemFontOfSize:14.0]];
    
    // Based on xib
    float baseOffset = 320.0 - 248.0;
    
    CGSize maxSize = CGSizeMake(width - baseOffset, 5000);
    CGSize size = [attrStr sizeConstrainedToSize:maxSize];
    
    return size.height + 30.0;
}

@end
