//
//  SessionDetail.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SessionDetail.h"

@implementation SessionDetail

@synthesize session;
@synthesize titleTextView;
@synthesize descriptionTextView;
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
    self.title = session.title;
    titleTextView.text = session.title;
    descriptionTextView.text = session.body;    

    CGRect frame = descriptionTextView.frame;
    frame.size.height = descriptionTextView.contentSize.height;
    descriptionTextView.frame = frame;
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, descriptionTextView.frame.origin.y + descriptionTextView.frame.size.height); 
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
