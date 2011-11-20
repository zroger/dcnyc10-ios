//
//  TwitterMessage.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TwitterUser;

@interface TwitterMessage : NSManagedObject

@property (nonatomic, retain) NSString * id_str;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) TwitterUser *user;

+ (void) initObjectMapping;

@end
