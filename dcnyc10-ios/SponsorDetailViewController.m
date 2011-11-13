//
//  SponsorDetailViewController.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SponsorDetailViewController.h"

@implementation SponsorDetailViewController

@synthesize sponsor;
@synthesize titleTextView;
@synthesize descriptionTextView;
@synthesize urlTextView;
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

    titleTextView.text = [sponsor title];
    descriptionTextView.text = [sponsor body];
    urlTextView.text = [sponsor url];

    NSURL * imageURL = [NSURL URLWithString:sponsor.logo];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    logoImageView.image = [UIImage imageWithData:imageData];
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

@end
