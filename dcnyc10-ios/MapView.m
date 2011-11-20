//
//  MapView.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"
#import "TestFlight.h"

@implementation MapView

@synthesize imageView;
@synthesize scrollView;

- (void) dealloc
{
    [imageView release];
    [scrollView release];
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
    
    self.title = NSLocalizedString(@"Maps", @"Maps");
    self.scrollView.contentSize=imageView.image.size;
    self.scrollView.minimumZoomScale = MIN((self.view.frame.size.width / imageView.image.size.width),
                                           (self.view.frame.size.height / imageView.image.size.height));
    NSLog(@"minimumZoomScale: %f", self.scrollView.minimumZoomScale);
    
    self.scrollView.delegate=self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [TestFlight passCheckpoint:@"Map view"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.scrollView.contentSize=imageView.image.size;
    self.scrollView.minimumZoomScale = self.view.frame.size.width / imageView.image.size.width;
    NSLog(@"minimumZoomScale: %f", self.scrollView.minimumZoomScale);
    [TestFlight passCheckpoint:@"Map view - rotated"];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)inScrollView
{
    NSLog(@"zoom; %f", inScrollView.zoomScale);

    [TestFlight passCheckpoint:@"Map view - zoom"];
}
@end
