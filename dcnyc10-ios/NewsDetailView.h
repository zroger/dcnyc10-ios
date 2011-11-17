//
//  NewsDetailView.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodNews.h"

@interface NewsDetailView : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) CodNews *article;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UIWebView *bodyWebView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@end
