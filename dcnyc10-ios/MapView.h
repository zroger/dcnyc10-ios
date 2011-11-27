//
//  MapView.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface MapView : UIViewController <UITabBarDelegate> {
    NSArray *images;
}

@property (nonatomic, retain) IBOutlet ImageScrollView *scrollView;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;

@end
