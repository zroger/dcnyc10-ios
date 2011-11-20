//
//  SponsorTableViewCell.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SponsorTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation SponsorTableViewCell

@synthesize sponsor;
@synthesize textLabel;
@synthesize detailTextLabel;
@synthesize imageView;

- (void) dealloc
{
    [sponsor release];
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

-(void) setSponsor:(CodSponsor *)newSponsor
{
    if (newSponsor != sponsor)
    {
        [newSponsor retain];
        [sponsor release];
        sponsor = newSponsor;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        textLabel.text = sponsor.title;
        detailTextLabel.text = sponsor.url;
        
        [imageView setImageWithURL:[NSURL URLWithString:sponsor.logo]
                  placeholderImage:[UIImage imageNamed:@"Contact.png"]];
    }
}

@end
