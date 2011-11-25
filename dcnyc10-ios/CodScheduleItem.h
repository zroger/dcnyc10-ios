//
//  CodScheduleItem.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <RestKit/CoreData/CoreData.h>

@interface CodScheduleItem : NSManagedObject

@property (nonatomic, retain) NSNumber * accepted;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSDate * changed;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * end;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSNumber * nid;
@property (nonatomic, retain) NSString * room;
@property (nonatomic, retain) NSDate * start;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * uri;

@end
