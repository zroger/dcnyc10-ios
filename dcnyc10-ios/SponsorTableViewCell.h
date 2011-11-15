//
//  SponsorTableViewCell.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodSponsor.h"

@interface SponsorTableViewCell : UITableViewCell

@property (nonatomic, retain) CodSponsor *sponsor;

@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UILabel *detailTextLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
