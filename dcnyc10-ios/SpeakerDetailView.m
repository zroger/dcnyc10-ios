//
//  SpeakerDetailView.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SpeakerDetailView.h"
#import "SessionTableViewCell.h"
#import "SessionDetail.h"
#import "TestFlight.h"
#import "UIImageView+WebCache.h"

@implementation SpeakerDetailView

@synthesize speaker;
@synthesize scrollView;
@synthesize topView;
@synthesize titleLabel;
@synthesize organizationLabel;
@synthesize imageView;
@synthesize sessionsTableView;
@synthesize descriptionTextView;

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
    self.title = [NSString stringWithFormat: @"%@ %@", speaker.first_name, speaker.last_name];
    // Do any additional setup after loading the view from its nib.

    titleLabel.text = self.title;
    organizationLabel.text = speaker.organization;

    [imageView setImageWithURL:[NSURL URLWithString:speaker.picture]
              placeholderImage:[UIImage imageNamed:@"Contact.png"]];
    

    CGRect frame = sessionsTableView.frame;
    frame.size.height = speaker.sessions.count * sessionsTableView.rowHeight + sessionsTableView.sectionHeaderHeight;
    sessionsTableView.frame = frame;
    
    frame = descriptionTextView.frame;
    frame.size.height = descriptionTextView.contentSize.height;
    frame.origin.y = sessionsTableView.frame.origin.y + sessionsTableView.frame.size.height;
    descriptionTextView.frame = frame;
    
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
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [sessionsTableView reloadData];
    CGRect frame = sessionsTableView.frame;
    frame.size.height = speaker.sessions.count * sessionsTableView.rowHeight + sessionsTableView.sectionHeaderHeight;
    sessionsTableView.frame = frame;
    
    frame = descriptionTextView.frame;
    frame.size.height = descriptionTextView.contentSize.height;
    frame.origin.y = sessionsTableView.frame.origin.y + sessionsTableView.frame.size.height;
    descriptionTextView.frame = frame;
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, descriptionTextView.frame.origin.y + descriptionTextView.frame.size.height); 
}

- (void)viewWillAppear:(BOOL)animated
{
    [TestFlight passCheckpoint:@"Speaker Detail View"];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Sessions";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [speaker.sessions count];
}

- (void)configureCell:(SessionTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    NSArray *sortedSessions = [[speaker.sessions allObjects] sortedArrayUsingDescriptors:sortDescriptors];

    cell.session = [sortedSessions objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    SessionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSLog(@"cell created");
        // Create a temporary UIViewController to instantiate the custom cell.
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"SessionTableViewCell" bundle:nil];
        // Grab a pointer to the custom cell.
        cell = (SessionTableViewCell *)temporaryController.view;
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
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    NSArray *sortedSessions = [[speaker.sessions allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    
    // Navigation logic may go here. Create and push another view controller.
    SessionDetail *detailViewController = [[SessionDetail alloc] initWithNibName:@"SessionDetail" bundle:nil];
    
    // Pass the selected object to the new view controller.
    detailViewController.session = [sortedSessions objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];

    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}


@end
