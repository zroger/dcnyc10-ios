//
//  ScheduleItemDetailView.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ScheduleItemDetailView.h"
#import "TestFlight.h"
#import "NotificationsController.h"

@implementation ScheduleItemDetailView

@synthesize scheduleItem;
@synthesize titleTextView;
@synthesize dateTextView;
@synthesize descriptionWebView;
@synthesize roomLabel;
@synthesize scrollView;
@synthesize starButton;

- (void) dealloc
{
    [scheduleItem release];
    [titleTextView release];
    [dateTextView release];
    [descriptionWebView release];
    [roomLabel release];
    [scrollView release];
    [starButton release];
    
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
    self.title = scheduleItem.title;
    
    self.navigationItem.rightBarButtonItem = starButton;
    if ([scheduleItem.favorite isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [starButton setImage:[UIImage imageNamed:@"star-active.png"]];
    }
    
    CGRect frame;
    
    titleTextView.text = scheduleItem.title;
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
                         [startFormatter stringFromDate:scheduleItem.start], 
                         [endFormatter stringFromDate:scheduleItem.end]];
    [startFormatter release];
    [endFormatter release];
    
    roomLabel.text = scheduleItem.room;
    frame = roomLabel.frame;
    frame.origin.y = dateTextView.frame.origin.y + dateTextView.frame.size.height;
    roomLabel.frame = frame;
    
    UIView *topView = roomLabel.superview;
    frame = topView.frame;
    frame.size.height = roomLabel.frame.origin.y + roomLabel.frame.size.height + 10.0;
    topView.frame = frame;    
        
    [descriptionWebView loadHTMLString:scheduleItem.body baseURL:[NSURL URLWithString:@"http://drupalcampnyc.org/"]];
    [descriptionWebView sizeToContent];
    
    frame = descriptionWebView.frame;
    frame.origin.y = topView.frame.origin.y + topView.frame.size.height + 20.0;
    descriptionWebView.frame = frame;
    
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
    
    frame = titleTextView.frame;
    frame.size.height = titleTextView.contentSize.height;
    titleTextView.frame = frame;
    
    frame = dateTextView.frame;
    frame.origin.y = titleTextView.frame.origin.y + titleTextView.frame.size.height - 10.0;
    dateTextView.frame = frame;
    
    frame = roomLabel.frame;
    frame.origin.y = dateTextView.frame.origin.y + dateTextView.frame.size.height;
    roomLabel.frame = frame;

    UIView *topView = roomLabel.superview;
    frame = topView.frame;
    frame.size.height = roomLabel.frame.origin.y + roomLabel.frame.size.height + 10.0;
    topView.frame = frame;    
        
    [descriptionWebView sizeToContent];    
    frame = descriptionWebView.frame;
    frame.origin.y = topView.frame.origin.y + topView.frame.size.height + 20.0;
    descriptionWebView.frame = frame;
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, descriptionWebView.frame.origin.y + descriptionWebView.frame.size.height); 
}

-(void)viewWillAppear:(BOOL)animated
{
#ifdef USE_TESTFLIGHT
    [TestFlight passCheckpoint:@"Schedule item detail View"];
#endif
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

- (IBAction)toggleFavorite:(id)sender {
    if ([scheduleItem.favorite isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [scheduleItem setFavorite:[NSNumber numberWithBool:NO]];
        [starButton setImage:[UIImage imageNamed:@"star-inactive.png"]];
        [NotificationsController cancelNotificationForSession:scheduleItem];
    }
    else {
        [scheduleItem setFavorite:[NSNumber numberWithBool:YES]];
        [starButton setImage:[UIImage imageNamed:@"star-active.png"]];        
        [NotificationsController scheduleNotificationForSession:scheduleItem];
    }
    
    NSError *error = nil;
    [scheduleItem.managedObjectContext save:&error];
    
#ifdef USE_TESTFLIGHT
    [TestFlight passCheckpoint:@"Favorite toggled from schedule item detail view"];
#endif
}

@end
