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

@implementation SponsorDetailViewController

@synthesize sponsor;
@synthesize titleLabel;
@synthesize descriptionTextView;
@synthesize urlButton;
@synthesize logoImageView;
@synthesize scrollView;

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
    
    // Logo Image View
    [logoImageView setImageWithURL:[NSURL URLWithString:sponsor.logo]
                  placeholderImage:[UIImage imageNamed:@"Contact.png"]];
    
    // Title Label
    titleLabel.text = [sponsor title];
    [titleLabel sizeToFit];
    
    // URL Button
    frame = urlButton.frame;
    frame.origin.y = titleLabel.frame.origin.y + (titleLabel.frame.size.height / 2) - (urlButton.frame.size.height / 2);
    urlButton.frame = frame;

    // Description Text View
    descriptionTextView.text = [sponsor body];
    frame = descriptionTextView.frame;
    frame.size.height = descriptionTextView.contentSize.height;
    frame.origin.y = titleLabel.frame.origin.y + titleLabel.frame.size.height;
    descriptionTextView.frame = frame;

    // Resize scroll view
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, descriptionTextView.frame.origin.y + descriptionTextView.frame.size.height); 

    UIImage *tileImage = [UIImage imageNamed:@"bg-repeat_light.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:tileImage];
    [tileImage release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    [TestFlight passCheckpoint:@"Sponsor Detail View"];
}

- (void)gotoSponsorUrl:(id)sender
{
    NSURL* url = [NSURL URLWithString:sponsor.url];
    if (url.scheme == nil) {
        [url release];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", sponsor.url]];
    }
    NSLog(@"%@", [url scheme]);
    [[UIApplication sharedApplication] openURL:url];
}

@end
