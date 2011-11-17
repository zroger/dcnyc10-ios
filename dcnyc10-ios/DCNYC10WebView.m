//
//  DCNYC10WebView.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DCNYC10WebView.h"

@implementation DCNYC10WebView

- (void) loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL {
    NSString *htmlWrapper = @"<html>"
        "<head>"
        "<style type=\"text/css\">"
        "   body,html{"
        "       margin:0;"
        "       padding:0;"
        "       background-color:transparent;"
        "       overview: hidden;"
        "   }"
        "   p {margin-bottom: 2em;}"
        "   a:link {color: #c24721; font-weight: bold;"
        "</style>"
        "</head>"
        "<body>%@</body>"
        "</html>";
    [self setBackgroundColor:[UIColor clearColor]];
    [self setOpaque:NO];
    [super loadHTMLString:[NSString stringWithFormat:htmlWrapper, string] baseURL:baseURL];
    
    for (id subview in self.subviews) {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
            ((UIScrollView *)subview).bounces = NO;            
        }
    }
}

- (void) sizeToContent
{
    CGRect frame = self.frame;
    frame.size.height = 1;
    self.frame = frame;
    CGSize fittingSize = [self sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    self.frame = frame;
}

@end
