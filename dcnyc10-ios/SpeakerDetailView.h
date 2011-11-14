//
//  SpeakerDetailView.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodSpeaker.h"

@interface SpeakerDetailView : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) CodSpeaker *speaker;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UIView *topView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *organizationLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) IBOutlet UITableView *sessionsTableView;

@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;

@end
