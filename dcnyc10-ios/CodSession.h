//
//  CodSession.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <RestKit/CoreData/CoreData.h>

@interface CodSession : NSManagedObject

@property (nonatomic, retain) NSNumber * nid;
@property (nonatomic, retain) NSString * uri;
@property (nonatomic, retain) NSString * title;

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * changed;

@property (nonatomic, retain) NSString * body;

@property (nonatomic, retain) NSString *experience;
@property (nonatomic, retain) NSString *track;

@property (nonatomic, retain) NSNumber *accepted;

@property (nonatomic, retain) NSDate * start;
@property (nonatomic, retain) NSDate * end;

@property (nonatomic, retain) NSNumber * capacity;
@property (nonatomic, retain) NSString * room;

@property (nonatomic, retain) NSSet *speakers;

@property (nonatomic, retain) NSNumber *favorite;

+ (void) initObjectMapping;

@end
