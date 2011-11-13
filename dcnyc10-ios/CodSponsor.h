//
//  CodSponsor.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <RestKit/CoreData/CoreData.h>

@interface CodSponsor : NSManagedObject

@property (nonatomic, retain) NSNumber *nid;
@property (nonatomic, retain) NSString *uri;
@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) NSDate *created;
@property (nonatomic, retain) NSDate *changed;

@property (nonatomic, retain) NSString *body;

@property (nonatomic, retain) NSString *level;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSString *url;

+ (void) initObjectMapping;

@end
