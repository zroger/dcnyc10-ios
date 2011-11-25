//
//  CodSession.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <RestKit/CoreData/CoreData.h>
#import "CodScheduleItem.h"

@class CodSpeaker;

@interface CodSession : CodScheduleItem

@property (nonatomic, retain) NSNumber * capacity;
@property (nonatomic, retain) NSString * experience;
@property (nonatomic, retain) NSString * track;
@property (nonatomic, retain) NSSet *speakers;
@end

@interface CodSession (CoreDataGeneratedAccessors)

- (void)addSpeakersObject:(CodSpeaker *)value;
- (void)removeSpeakersObject:(CodSpeaker *)value;
- (void)addSpeakers:(NSSet *)values;
- (void)removeSpeakers:(NSSet *)values;
@end
