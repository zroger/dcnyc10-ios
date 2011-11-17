//
//  SponsorDetailViewController.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodSponsor.h"
#import "DCNYC10WebView.h"

@interface SponsorDetailViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) CodSponsor *sponsor;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet DCNYC10WebView *descriptionWebView;
@property (nonatomic, retain) IBOutlet UIImageView *logoImageView;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *actionBarButtonItem;

- (IBAction)gotoSponsorUrl:(id)sender;

@end
