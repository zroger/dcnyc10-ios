//
//  SessionDetail.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SessionDetail.h"
#import "SpeakerTableViewCell.h"
#import "SpeakerDetailView.h"
#import "TestFlight.h"
#import "MREntitiesConverter.h"
#import "NotificationsController.h"

@implementation SessionDetail

@synthesize session;
@synthesize titleTextView;
@synthesize dateTextView;
@synthesize descriptionWebView;

@synthesize roomLabel;
@synthesize trackLabel;

@synthesize scrollView;
@synthesize speakersTableView;

@synthesize starButton;

- (void) dealloc
{
    [session release];
    [titleTextView release];
    [dateTextView release];
    [descriptionWebView release];
    [roomLabel release];
    [trackLabel release];
    [scrollView release];
    [speakersTableView release];
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
    self.title = session.title;
    
    self.navigationItem.rightBarButtonItem = starButton;
    if ([session.favorite isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [starButton setImage:[UIImage imageNamed:@"star-active.png"]];
    }

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
    [startFormatter release];
    [endFormatter release];

    roomLabel.text = session.room;
    frame = roomLabel.frame;
    frame.origin.y = dateTextView.frame.origin.y + dateTextView.frame.size.height;
    roomLabel.frame = frame;

    // Track
    MREntitiesConverter *converter = [[[MREntitiesConverter alloc] init] autorelease];
    trackLabel.text = [converter convertEntiesInString:session.track];
    frame = trackLabel.frame;
    frame.origin.y = dateTextView.frame.origin.y + dateTextView.frame.size.height;
    trackLabel.frame = frame;
    
    frame = roomLabel.superview.frame;
    frame.size.height = roomLabel.frame.origin.y + roomLabel.frame.size.height + 10.0;
    roomLabel.superview.frame = frame;    

    frame = speakersTableView.frame;
    frame.size.height = session.speakers.count * speakersTableView.rowHeight + speakersTableView.sectionHeaderHeight;
    frame.origin.y = roomLabel.superview.frame.origin.y + roomLabel.superview.frame.size.height;
    speakersTableView.frame = frame;

    [descriptionWebView loadHTMLString:session.body baseURL:[NSURL URLWithString:@"http://drupalcampnyc.org/"]];
    [descriptionWebView sizeToContent];

    frame = descriptionWebView.frame;
    frame.origin.y = speakersTableView.frame.origin.y + speakersTableView.frame.size.height + 20.0;
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
    // Return YES for supported orientations
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    
    frame = trackLabel.frame;
    frame.origin.y = dateTextView.frame.origin.y + dateTextView.frame.size.height;
    trackLabel.frame = frame;
    
    frame = roomLabel.superview.frame;
    frame.size.height = roomLabel.frame.origin.y + roomLabel.frame.size.height + 10.0;
    roomLabel.superview.frame = frame;    
    
    frame = speakersTableView.frame;
    frame.size.height = session.speakers.count * speakersTableView.rowHeight + speakersTableView.sectionHeaderHeight;
    frame.origin.y = roomLabel.superview.frame.origin.y + roomLabel.superview.frame.size.height;
    speakersTableView.frame = frame;
    
    [descriptionWebView sizeToContent];    
    frame = descriptionWebView.frame;
    frame.origin.y = speakersTableView.frame.origin.y + speakersTableView.frame.size.height + 20.0;
    descriptionWebView.frame = frame;
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, descriptionWebView.frame.origin.y + descriptionWebView.frame.size.height); 
}

-(void)viewWillAppear:(BOOL)animated
{
#ifdef USE_TESTFLIGHT
    [TestFlight passCheckpoint:@"Session Detail View"];
#endif
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Speakers";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [session.speakers count];
}

- (void)configureCell:(SpeakerTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"first_name" ascending:YES]];
    NSArray *sortedSpeakers = [[session.speakers allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    
    cell.speaker = [sortedSpeakers objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    SpeakerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // Create a temporary UIViewController to instantiate the custom cell.
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"SpeakerTableViewCell" bundle:nil];
        // Grab a pointer to the custom cell.
        cell = (SpeakerTableViewCell *)temporaryController.view;
        // Release the temporary UIViewController.
        [temporaryController release];
    }
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"first_name" ascending:YES]];
    NSArray *sortedSpeakers = [[session.speakers allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    
    // Navigation logic may go here. Create and push another view controller.
    SpeakerDetailView *detailViewController = [[SpeakerDetailView alloc] initWithNibName:@"SpeakerDetailView" bundle:nil];
    
    // Pass the selected object to the new view controller.
    detailViewController.speaker = [sortedSpeakers objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
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
    if ([session.favorite isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [session setFavorite:[NSNumber numberWithBool:NO]];
        [starButton setImage:[UIImage imageNamed:@"star-inactive.png"]];
        [NotificationsController cancelNotificationForSession:session];
    }
    else {
        [session setFavorite:[NSNumber numberWithBool:YES]];
        [starButton setImage:[UIImage imageNamed:@"star-active.png"]];        
        [NotificationsController scheduleNotificationForSession:session];
    }
    
    NSError *error = nil;
    [session.managedObjectContext save:&error];
    
#ifdef USE_TESTFLIGHT
    [TestFlight passCheckpoint:@"Favorite toggled from session detail view"];
#endif
}

@end
