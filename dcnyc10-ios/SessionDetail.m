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
@synthesize dateTextView;
@synthesize descriptionTextView;

@synthesize roomLabel;
@synthesize trackLabel;

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

    CGRect frame;
    
    titleTextView.text = session.title;
    frame = titleTextView.frame;
    frame.size.height = titleTextView.contentSize.height;
    titleTextView.frame = frame;

    frame = dateTextView.frame;
    frame.origin.y = titleTextView.frame.origin.y + titleTextView.frame.size.height - 10.0;
    dateTextView.frame = frame;

    NSDateFormatter *startFormatter = [[NSDateFormatter alloc] init];
    startFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
    [startFormatter setDateFormat:@"EEEE, MMMM d\nh:mma"];

    NSDateFormatter *endFormatter = [[NSDateFormatter alloc] init];
    endFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
    [endFormatter setDateFormat:@"h:mma"];

    dateTextView.text = [NSString stringWithFormat:@"%@ - %@", 
                         [startFormatter stringFromDate:session.start], 
                         [endFormatter stringFromDate:session.end]];

    roomLabel.text = session.room;
    frame = roomLabel.frame;
    frame.origin.y = dateTextView.frame.origin.y + dateTextView.frame.size.height;
    roomLabel.frame = frame;

    trackLabel.text = session.track;
    frame = trackLabel.frame;
    frame.origin.y = dateTextView.frame.origin.y + dateTextView.frame.size.height;
    trackLabel.frame = frame;
    
    frame = roomLabel.superview.frame;
    frame.size.height = roomLabel.frame.origin.y + roomLabel.frame.size.height;
    roomLabel.superview.frame = frame;    
    
    descriptionTextView.text = session.body;    
    frame = descriptionTextView.frame;
    frame.size.height = descriptionTextView.contentSize.height;
    descriptionTextView.frame = frame;

    frame = descriptionTextView.superview.frame;
    frame.size.height = descriptionTextView.contentSize.height;
    frame.origin.y = dateTextView.superview.frame.size.height;
    descriptionTextView.superview.frame = frame;
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, descriptionTextView.superview.frame.origin.y + descriptionTextView.superview.frame.size.height); 
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
