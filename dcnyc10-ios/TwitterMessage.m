//
//  TwitterMessage.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterMessage.h"
#import "TwitterUser.h"
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

@implementation TwitterMessage

@dynamic id_str;
@dynamic created_at;
@dynamic text;
@dynamic user;

+ (void) initObjectMapping {
    RKManagedObjectMapping* twitterUserMapping = [RKManagedObjectMapping mappingForClass:[TwitterUser class]];
    [twitterUserMapping mapAttributes:@"name", @"profile_image_url", @"id_str", @"screen_name", nil];
    twitterUserMapping.primaryKeyAttribute = @"id_str";
    
    [[RKObjectManager sharedManager].mappingProvider addObjectMapping:twitterUserMapping];
    
    RKManagedObjectMapping* twitterMessageMapping = [RKManagedObjectMapping mappingForClass:[TwitterMessage class]];
    [twitterMessageMapping mapAttributes:@"id_str", @"created_at", @"text", nil];
    twitterMessageMapping.primaryKeyAttribute = @"id_str";

    [twitterMessageMapping mapKeyPath:@"user" toRelationship:@"user" withMapping:twitterUserMapping];
    
    NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    // "created_at": "Tue Nov 15 23:30:11 +0000 2011",
    [dateFormatter setDateFormat:@"E MMM d HH:mm:ss Z y"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    twitterMessageMapping.dateFormatters = [NSArray arrayWithObject: dateFormatter];
    
    [[RKObjectManager sharedManager].mappingProvider addObjectMapping:twitterMessageMapping];
}

@end
