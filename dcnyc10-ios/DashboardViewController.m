//
//  DashboardViewController.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DashboardViewController.h"
#import "SessionsTable.h"
#import "SponsorsTableViewController.h"
#import "SpeakerTableView.h"
#import "NewsTableView.h"
#import "MapView.h"
#import "SettingsView.h"

#import "TestFlight.h"

@implementation DashboardViewController

@synthesize feedbackButton;
@synthesize landscapeView;

- (void) dealloc
{
    [feedbackButton release];
    [landscapeView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"DrupalCampNYC 10";
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
    self.navigationItem.rightBarButtonItem = feedbackButton;

    UIImage *tileImage = [UIImage imageNamed:@"bg-repeat_light.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:tileImage];
    self.landscapeView.backgroundColor = [UIColor colorWithPatternImage:tileImage];

    [self.view addSubview:landscapeView];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"DrupalCampNYC 10";
    [TestFlight passCheckpoint:@"Dashboard View"];
}

- (void) viewWillDisappear:(BOOL)animated
{
    // Change the title to "Home" to get a shorter back button.
    self.title = @"Home";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [landscapeView setHidden:YES];
    } 
    else {
        [landscapeView setHidden:NO];
        landscapeView.frame = self.view.frame;
    }
    return YES;
}

- (IBAction)gotoSessions:(id)sender
{
    SessionsTable *sessionsTableController = [[SessionsTable alloc] initWithNibName:@"SessionsTable" bundle:nil];
    [self.navigationController pushViewController:sessionsTableController animated:YES];
    [sessionsTableController release];
}

- (IBAction)gotoSponsors:(id)sender
{
    SponsorsTableViewController *sponsorsTableViewController = [[SponsorsTableViewController alloc] initWithNibName:@"SponsorsTableViewController" bundle:nil];
    [self.navigationController pushViewController:sponsorsTableViewController animated:YES];
    [sponsorsTableViewController release];
}

- (IBAction)gotoSpeakers:(id)sender
{
    SpeakerTableView *speakersTableView = [[SpeakerTableView alloc] initWithNibName:@"SpeakerTableView" bundle:nil];
    [self.navigationController pushViewController:speakersTableView animated:YES];
    [speakersTableView release];
}

- (IBAction)feedback:(id)sender
{
    [TestFlight openFeedbackView];
}

- (IBAction)gotoMaps:(id)sender
{
    MapView *mapView = [[MapView alloc] initWithNibName:@"MapView" bundle:nil];
    [self.navigationController pushViewController:mapView animated:YES];
    [mapView release];
}

- (IBAction)gotoTweets:(id)sender
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Coming soon" message:@"This feature is still in development" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alert show];
}

- (IBAction)gotoNews:(id)sender
{
    NewsTableView *newsTableView = [[NewsTableView alloc] initWithNibName:@"NewsTableView" bundle:nil];
    [self.navigationController pushViewController:newsTableView animated:YES];
    [newsTableView release];
}

- (IBAction)gotoInfo:(id)sender
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Coming soon" message:@"This feature is still in development" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alert show];
}

- (IBAction)gotoSocial:(id)sender
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Coming soon" message:@"This feature is still in development" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alert show]; 
}

- (IBAction)gotoSettings:(id)sender
{
    SettingsView *settingsView = [[[SettingsView alloc] initWithNibName:@"SettingsView" bundle:nil] autorelease];
    [self.navigationController pushViewController:settingsView animated:YES];
}

@end
