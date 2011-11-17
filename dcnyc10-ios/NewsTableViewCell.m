//
//  NewsTableViewCell.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

@synthesize article;

@synthesize textLabel;
@synthesize detailTextLabel;
@synthesize imageView;

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

-(void) setArticle:(CodNews *)newArticle
{
    if (newArticle != article)
    {
        [newArticle retain];
        [article release];
        article = newArticle;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        textLabel.text = article.title;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
        [dateFormatter setDateFormat:@"EEEE MMMM d, YYYY"];
        
        detailTextLabel.text = [dateFormatter stringFromDate:article.created];        
    }
}

@end
