//
//  DashboardViewController.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIBarButtonItem *feedbackButton;
@property (nonatomic, retain) IBOutlet UIView *landscapeView;

- (IBAction)gotoSessions:(id)sender;
- (IBAction)gotoSpeakers:(id)sender;
- (IBAction)gotoMaps:(id)sender;
- (IBAction)gotoTweets:(id)sender;
- (IBAction)gotoSponsors:(id)sender;
- (IBAction)gotoNews:(id)sender;
- (IBAction)gotoInfo:(id)sender;
- (IBAction)gotoSocial:(id)sender;
- (IBAction)gotoSettings:(id)sender;

- (IBAction)feedback:(id)sender;

@end
