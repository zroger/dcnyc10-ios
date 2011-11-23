//
//  SponsorDetailViewController.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SponsorDetailViewController.h"
#import "TestFlight.h"
#import "UIImageView+WebCache.h"
#import "UILabel+DynamicHeight.h"

@implementation SponsorDetailViewController

@synthesize sponsor;
@synthesize titleLabel;
@synthesize descriptionWebView;
@synthesize logoImageView;
@synthesize scrollView;
@synthesize actionBarButtonItem;

- (void) dealloc
{
    [sponsor release];
    [titleLabel release];
    [descriptionWebView release];
    [logoImageView release];
    [scrollView release];
    [actionBarButtonItem release];
    [super dealloc];
}

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
    // Do any additional setup after loading the view from its nib.

    self.title = sponsor.title;

    CGRect frame;

    // Show the action button in the navigation bar.
    self.navigationItem.rightBarButtonItem = actionBarButtonItem;
    
    // Logo Image View
    [logoImageView setImageWithURL:[NSURL URLWithString:sponsor.logo]
                  placeholderImage:[UIImage imageNamed:@"Contact.png"]];
    
    // Title Label
    titleLabel.text = [sponsor title];
    [titleLabel sizeWithDynamicHeight];
    
    // Description Web View
    [descriptionWebView loadHTMLString:sponsor.body baseURL:[NSURL URLWithString:@"http://drupalcampnyc.org/"]];
    [descriptionWebView sizeToContent];

    frame = descriptionWebView.frame;
    frame.origin.y = titleLabel.frame.origin.y + titleLabel.frame.size.height;
    descriptionWebView.frame = frame;

    // Resize scroll view
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, descriptionWebView.frame.origin.y + descriptionWebView.frame.size.height); 

    UIImage *tileImage = [UIImage imageNamed:@"bg-repeat_light.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:tileImage];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
    // Description Web View
    [descriptionWebView sizeToContent];
    
    frame = descriptionWebView.frame;
    frame.origin.y = titleLabel.frame.origin.y + titleLabel.frame.size.height;
    descriptionWebView.frame = frame;
    
    // Resize scroll view
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, descriptionWebView.frame.origin.y + descriptionWebView.frame.size.height); 
}

- (void)viewWillAppear:(BOOL)animated
{
#ifdef USE_TESTFLIGHT
    [TestFlight passCheckpoint:@"Sponsor Detail View"];
#endif
}

- (void)gotoSponsorUrl:(id)sender
{
    NSURL* url = [NSURL URLWithString:sponsor.url];
    if (url.scheme == nil) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", sponsor.url]];
    }
    NSLog(@"%@", [url scheme]);
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - UIWebViewDelegate methods

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    [descriptionWebView sizeToContent];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, descriptionWebView.frame.origin.y + descriptionWebView.frame.size.height); 
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
