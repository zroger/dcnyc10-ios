//
//  MapView.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
//  See http://cocoadevblog.heroku.com/iphone-tutorial-uiimage-with-zooming-tapping-rotation
//

#import "MapView.h"
#import "TestFlight.h"
#import "SimpleAnnotation.h"

@implementation MapView

@synthesize scrollView;
@synthesize mapView;
@synthesize tabBar;

- (void) dealloc
{
    [images release];
    [scrollView release];
    [mapView release];
    [tabBar release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        images = [[NSArray arrayWithObjects: [UIImage imageNamed:@"floorplan-floor2.png"],
                   [UIImage imageNamed:@"floorplan-floor3.png"],
                   [UIImage imageNamed:@"floorplan-floor6.png"],
                   [UIImage imageNamed:@"floorplan-cafeteria.png"], nil] retain];
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
    
    self.title = NSLocalizedString(@"Maps", @"Maps");

    [scrollView setDelegate:scrollView];
    [scrollView displayImage:[images objectAtIndex:0]];
   
    [tabBar setSelectedItem:[[tabBar items] objectAtIndex:0]];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 40.770329;
    coordinate.longitude = -73.987754;
    SimpleAnnotation *annotation = [[[SimpleAnnotation alloc] initWithName:@"John Jay College" address:@"899 10th Avenue\nNew York, 10019" coordinate:coordinate] autorelease];
    [mapView addAnnotation:annotation];            
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
#ifdef USE_TESTFLIGHT
    [TestFlight passCheckpoint:@"Map view"];
#endif
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration      
{
    CGPoint restorePoint = [scrollView pointToCenterAfterRotation];
    CGFloat restoreScale = [scrollView scaleToRestoreAfterRotation];
    
    scrollView.frame = scrollView.bounds;
    
    [scrollView setMaxMinZoomScalesForCurrentBounds];
    [scrollView restoreCenterPoint:restorePoint scale:restoreScale];    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
#ifdef USE_TESTFLIGHT
    [TestFlight passCheckpoint:@"Map view - rotated"];
#endif
}

#pragma mark - UITabBarDelegate 
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 99) {
        SimpleAnnotation *annotation = [mapView.annotations objectAtIndex:0];

        // Center view on annotation
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
        [mapView setRegion:adjustedRegion animated:NO];        

        // Open annotation view
        [mapView selectAnnotation:annotation animated:NO];
        
        [mapView setHidden:NO];
        [scrollView setHidden:YES];
        return;
    }

    [mapView setHidden:YES];
    [scrollView setHidden:NO];
    [scrollView displayImage:[images objectAtIndex:item.tag]];
}

@end
