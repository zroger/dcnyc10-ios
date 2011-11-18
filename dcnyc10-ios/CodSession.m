//
//  CodSession.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CodSession.h"
#import <RestKit/RestKit.h>

@implementation CodSession

@dynamic nid;
@dynamic title;
@dynamic uri;

@dynamic created;
@dynamic changed;

@dynamic body;

@dynamic experience;
@dynamic track;

@dynamic accepted;

@dynamic room;
@dynamic capacity;

@dynamic start;
@dynamic end;

@dynamic speakers;

@dynamic favorite;

+ (void) initObjectMapping {
    RKManagedObjectMapping* sessionMapping = [RKManagedObjectMapping mappingForClass:[CodSession class]];
    [sessionMapping mapAttributes:@"nid", @"title", @"uri",
                                  @"created", @"changed", @"accepted",
                                  @"body", @"experience", @"track",
                                  @"room", @"capacity", @"start", @"end", nil];

    sessionMapping.primaryKeyAttribute = @"nid";
    [[RKObjectManager sharedManager].mappingProvider setMapping:sessionMapping forKeyPath:@"session"];
}

@end
