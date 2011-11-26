//
//  ScheduleItemDetailView.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodScheduleItem.h"
#import "DCNYC10WebView.h"

@interface ScheduleItemDetailView : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) CodScheduleItem *scheduleItem;
@property (nonatomic, retain) IBOutlet UITextView *titleTextView;
@property (nonatomic, retain) IBOutlet UITextView *dateTextView;
@property (nonatomic, retain) IBOutlet DCNYC10WebView *descriptionWebView;

@property (nonatomic, retain) IBOutlet UILabel *roomLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *starButton;

- (IBAction)toggleFavorite:(id)sender;

@end

