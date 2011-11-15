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

- (IBAction)gotoSessions:(id)sender;
- (IBAction)gotoSponsors:(id)sender;
- (IBAction)gotoSpeakers:(id)sender;

- (IBAction)feedback:(id)sender;

@end
