//
//  CodSpeaker.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CodSpeaker : NSManagedObject

@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * organization;
@property (nonatomic, retain) NSString * uri;
@property (nonatomic, retain) NSSet * sessions;

+ (void) initObjectMapping;

@end
