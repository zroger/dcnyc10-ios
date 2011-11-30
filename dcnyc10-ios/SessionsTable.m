//
//  SessionsTable.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SessionsTable.h"
#import "CodSession.h"
#import "CodScheduleItem.h"
#import "SessionDetail.h"
#import "SessionTableViewCell.h"
#import "ScheduleItemTableViewCell.h"
#import "ScheduleItemDetailView.h"
#import "TestFlight.h"

@implementation SessionsTable

@synthesize sessions;
@synthesize fetchedResultsController;

- (void)dealloc {
    self.fetchedResultsController.delegate = nil;
    self.fetchedResultsController = nil;

    [sessions release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Sessions", @"Sessions");
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    self.title = NSLocalizedString(@"Sessions", @"Sessions");

    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"accepted = %@ && start != NULL", [NSNumber numberWithBool:YES]];
    self.fetchedResultsController = [CodScheduleItem fetchRequestAllGroupedBy:@"start" 
                                                           withPredicate:predicate
                                                                sortedBy:@"start" 
                                                               ascending:true];

    self.fetchedResultsController.fetchRequest.sortDescriptors = [NSArray arrayWithObjects:
        [NSSortDescriptor sortDescriptorWithKey:@"start" ascending:true],
        [NSSortDescriptor sortDescriptorWithKey:@"room" ascending:TRUE], nil];

    self.fetchedResultsController.fetchRequest.includesSubentities = YES;
    self.fetchedResultsController.delegate = self;

    NSError *error;
	if (![self.fetchedResultsController performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}

    NSLog(@"%@", self.fetchedResultsController.fetchedObjects);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.fetchedResultsController = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
#ifdef USE_TESTFLIGHT
    [TestFlight passCheckpoint:@"Sessions Table View"];
#endif
    [[self tableView] reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[fetchedResultsController sections] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    CodScheduleItem *session = [[sectionInfo objects] objectAtIndex:0];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EST"];
    [dateFormatter setDateFormat:@"EEE MMM d, h:mm a"];

    NSString *title = [dateFormatter stringFromDate:session.start];
    [dateFormatter release];
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (cell.class == [SessionTableViewCell class]) {
        [(SessionTableViewCell *)cell setSession:[fetchedResultsController objectAtIndexPath:indexPath]];
    }
    else {
        [(ScheduleItemTableViewCell *)cell setScheduleItem:[fetchedResultsController objectAtIndexPath:indexPath]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static int cellCount = 0;

    CodScheduleItem *item = [fetchedResultsController objectAtIndexPath:indexPath];

    NSString *cellIdentifier;
    NSString *nibName;
    UITableViewCell *cell;

    if (item.class == [CodSession class]) {
        cellIdentifier = @"SessionTableViewCell";
        nibName = @"SessionTableViewCell";
    }
    else {
        cellIdentifier = @"ScheduleItemTableViewCell";
        nibName = @"ScheduleItemTableViewCell";
    }

    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        // Create a temporary UIViewController to instantiate the custom cell.
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:nibName bundle:nil];
        // Grab a pointer to the custom cell.
        cell = (UITableViewCell *)temporaryController.view;
        // Release the temporary UIViewController.
        [temporaryController release];
        cellCount++;
    }

    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CodScheduleItem *item = [fetchedResultsController objectAtIndexPath:indexPath];
    
    if (item.class == [CodSession class]) {
        return 72.0;
    }
    else {
        return 52.0;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CodScheduleItem *item = [fetchedResultsController objectAtIndexPath:indexPath];
    UIViewController *detailViewController;
    
    if (item.class == [CodSession class]) {
        // Navigation logic may go here. Create and push another view controller.
        detailViewController = [[SessionDetail alloc] initWithNibName:@"SessionDetail" bundle:nil];
        // Pass the selected object to the new view controller.
        [(SessionDetail *)detailViewController setSession:(CodSession *)item];
    }
    else {
        // Navigation logic may go here. Create and push another view controller.
        detailViewController = [[ScheduleItemDetailView alloc] initWithNibName:@"ScheduleItemDetailView" bundle:nil];
        // Pass the selected object to the new view controller.
        [(ScheduleItemDetailView *)detailViewController setScheduleItem:item];
    }

    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];

    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}

#pragma mark - NSFetchedResultsController delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, 
    // so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(SessionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            // Reloading the section inserts a new row and ensures that titles are updated appropriately.
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:newIndexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

- (void) refresh
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/schedule" delegate:self]; 
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error in refetch: %@",[error localizedDescription]);
        abort();
    }

    [self.tableView reloadData];
    [self stopLoading];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    refreshLabel.text = @"Connection failed.";
    refreshLabel.backgroundColor = [UIColor customRedColor];
    [refreshSpinner stopAnimating];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(dismissRefreshError) userInfo:nil repeats:NO];
}

- (void)dismissRefreshError
{
    [self stopLoading];
    refreshLabel.backgroundColor = [UIColor clearColor];
}

@end
