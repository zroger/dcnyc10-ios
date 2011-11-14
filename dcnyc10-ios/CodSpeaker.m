//
//  CodSpeaker.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CodSpeaker.h"
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

@implementation CodSpeaker

@dynamic uid;
@dynamic name;
@dynamic picture;
@dynamic first_name;
@dynamic last_name;
@dynamic organization;
@dynamic uri;
@dynamic sessions;

+ (void) initObjectMapping {
    RKManagedObjectMapping* speakerMapping = [RKManagedObjectMapping mappingForClass:[CodSpeaker class]];
    [speakerMapping mapAttributes:@"uid", @"name", @"picture", @"first_name", @"last_name",
                                  @"organization", @"uri", nil];
    speakerMapping.primaryKeyAttribute = @"uid";
    [[RKObjectManager sharedManager].mappingProvider setMapping:speakerMapping forKeyPath:@"speakers"];
}

@end
