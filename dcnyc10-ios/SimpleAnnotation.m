//
//  SimpleAnnotation.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SimpleAnnotation.h"

@implementation SimpleAnnotation

@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (void)dealloc
{
    [_name release];
    _name = nil;
    [_address release];
    _address = nil;    
    [super dealloc];
}
@end

