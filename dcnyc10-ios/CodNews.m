//
//  CodNews.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CodNews.h"
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

@implementation CodNews

@dynamic nid;
@dynamic title;
@dynamic created;
@dynamic changed;
@dynamic body;
@dynamic uri;

+ (void) initObjectMapping {
    RKManagedObjectMapping* newsMapping = [RKManagedObjectMapping mappingForClass:[CodNews class]];
    [newsMapping mapAttributes:@"nid", @"title", @"created", @"changed", @"body", @"uri", nil];
    newsMapping.primaryKeyAttribute = @"nid";

    [[RKObjectManager sharedManager].mappingProvider setMapping:newsMapping forKeyPath:@"news"];
}

@end
