//
//  SpeakerTableViewCell.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodSpeaker.h"

@interface SpeakerTableViewCell : UITableViewCell

@property (nonatomic, retain) CodSpeaker *speaker;

@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UILabel *detailTextLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
