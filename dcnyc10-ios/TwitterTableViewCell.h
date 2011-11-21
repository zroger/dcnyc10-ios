//
//  TwitterTableViewCell.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterMessage.h"
#import "DCNYC10WebView.h"
#import "OHAttributedLabel.h"

@interface TwitterTableViewCell : UITableViewCell

@property (nonatomic, retain) TwitterMessage *tweet;
@property (nonatomic, retain) IBOutlet OHAttributedLabel *textLabel;
@property (nonatomic, retain) IBOutlet UILabel *detailTextLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

- (void) doLayout;
+ (CGFloat) heightForCellWithString:(NSString *)string andWidth:(CGFloat)width;

@end
