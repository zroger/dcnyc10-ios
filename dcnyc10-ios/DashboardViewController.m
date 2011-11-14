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
#import "TestFlight.h"

@implementation DashboardViewController

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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    [SponsorsTableViewController release];
}

- (IBAction)gotoSpeakers:(id)sender
{
    SpeakerTableView *speakersTableView = [[SpeakerTableView alloc] initWithNibName:@"SpeakerTableView" bundle:nil];
    [self.navigationController pushViewController:speakersTableView animated:YES];
    [SpeakerTableView release];
}

@end
