//
//  NewsDetailView.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailView.h"
#import "UILabel+DynamicHeight.h"

@implementation NewsDetailView

@synthesize article;
@synthesize titleLabel;
@synthesize dateLabel;
@synthesize bodyWebView;
@synthesize scrollView;
@synthesize headerImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = article.title;
    
    CGRect frame;
    
    // Date label
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
    [dateFormatter setDateFormat:@"EEEE MMMM d, YYYY"];
    dateLabel.text = [dateFormatter stringFromDate:article.created];        
    [dateFormatter release];

    // Title Label
    titleLabel.text = article.title;
    [titleLabel sizeWithDynamicHeight];
    
    frame = headerImageView.frame;
    frame.size.height = titleLabel.frame.origin.y + titleLabel.frame.size.height + 20.0;
    headerImageView.frame = frame; 
    
    [bodyWebView loadHTMLString:article.body baseURL:[NSURL URLWithString:@"http://drupalcampnyc.org/"]];
    [bodyWebView sizeToContent];

    frame = bodyWebView.frame;
    frame.origin.y = headerImageView.frame.origin.y + headerImageView.frame.size.height + 20.0;
    bodyWebView.frame = frame;

    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, bodyWebView.frame.origin.y + bodyWebView.frame.size.height); 
    
    UIImage *tileImage = [UIImage imageNamed:@"bg-repeat_light.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:tileImage];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    CGRect frame;
    
    // Title Label
    [titleLabel sizeWithDynamicHeight];

    // Header image
    frame = headerImageView.frame;
    frame.size.height = titleLabel.frame.origin.y + titleLabel.frame.size.height + 20.0;
    headerImageView.frame = frame; 
    
    // Body Web View
    [bodyWebView sizeToContent];
    frame = bodyWebView.frame;
    frame.origin.y = headerImageView.frame.origin.y + headerImageView.frame.size.height + 20.0;
    bodyWebView.frame = frame;

    // Scroll View
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, bodyWebView.frame.origin.y + bodyWebView.frame.size.height); 
    
}

#pragma mark - UIWebViewDelegate methods

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    [bodyWebView sizeToContent];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, bodyWebView.frame.origin.y + bodyWebView.frame.size.height); 
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
