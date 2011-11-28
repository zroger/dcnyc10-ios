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
@dynamic acceptedSessions;

+ (void) initObjectMapping {
    RKManagedObjectMapping* speakerMapping = [RKManagedObjectMapping mappingForClass:[CodSpeaker class]];
    [speakerMapping mapAttributes:@"uid", @"name", @"picture", @"first_name", @"last_name",
                                  @"organization", @"uri", nil];
    speakerMapping.primaryKeyAttribute = @"uid";
    [[RKObjectManager sharedManager].mappingProvider setMapping:speakerMapping forKeyPath:@"speakers"];
}

- (NSString *) firstInitial {
    [self willAccessValueForKey:@"firstInitial"];
    if (self.first_name == nil || [self.first_name isEqualToString:@""]) {
        return @"#";
    }
    NSString * initial = [[[self first_name] substringToIndex:1] uppercaseString];
    [self didAccessValueForKey:@"firstInitial"];
    return initial;
}

- (NSArray *) acceptedSessions 
{
    [self willAccessValueForKey:@"acceptedSessions"];

    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"accepted == TRUE and start != nil"];
    NSArray *results = [[self.sessions filteredSetUsingPredicate:predicate] sortedArrayUsingDescriptors:sortDescriptors];

    [self didAccessValueForKey:@"acceptedSessions"];
    return results;    
}
@end
