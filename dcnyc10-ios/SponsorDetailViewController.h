//
//  SponsorDetailViewController.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodSponsor.h"

@interface SponsorDetailViewController : UIViewController

@property (nonatomic, retain) CodSponsor *sponsor;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, retain) IBOutlet UIButton *urlButton;
@property (nonatomic, retain) IBOutlet UIImageView *logoImageView;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (IBAction)gotoSponsorUrl:(id)sender;

@end
