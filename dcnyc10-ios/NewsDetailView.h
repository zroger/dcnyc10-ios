//
//  NewsDetailView.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodNews.h"
#import "DCNYC10WebView.h"

@interface NewsDetailView : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) CodNews *article;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet DCNYC10WebView *bodyWebView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIImageView *headerImageView;

@end
