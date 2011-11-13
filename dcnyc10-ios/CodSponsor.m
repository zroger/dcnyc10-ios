//
//  CodSponsor.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CodSponsor.h"
#import <RestKit/RestKit.h>

@implementation CodSponsor

@dynamic nid;
@dynamic title;
@dynamic uri;

@dynamic created;
@dynamic changed;

@dynamic body;

@dynamic level;
@dynamic logo;
@dynamic url;

+ (void) initObjectMapping {
    RKManagedObjectMapping* sponsorMapping = [RKManagedObjectMapping mappingForClass:[CodSponsor class]];
    [sponsorMapping mapAttributes:@"nid", @"title", @"uri",
                                  @"created", @"changed", @"body", 
                                  @"level", @"logo", @"url", nil];
    
    sponsorMapping.primaryKeyAttribute = @"nid";
    [[RKObjectManager sharedManager].mappingProvider setMapping:sponsorMapping forKeyPath:@"sponsor"];
}

@end
