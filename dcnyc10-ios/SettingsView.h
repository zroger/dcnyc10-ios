//
//  SettingsView.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsView : UITableViewController

@property (nonatomic, retain) IBOutlet UITableViewCell *cell0;
@property (nonatomic, retain) IBOutlet UITableViewCell *cell1;

@property (nonatomic, retain) IBOutlet UISwitch *alertsSwitch;

- (IBAction)alertsValueChanged:(id)sender;

@end
