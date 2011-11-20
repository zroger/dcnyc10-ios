//
//  TwitterUser.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TwitterUser : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * profile_image_url;
@property (nonatomic, retain) NSString * id_str;
@property (nonatomic, retain) NSString * screen_name;
@property (nonatomic, retain) NSSet *tweets;

@end

@interface TwitterUser (CoreDataGeneratedAccessors)

- (void)addTweetsObject:(NSManagedObject *)value;
- (void)removeTweetsObject:(NSManagedObject *)value;
- (void)addTweets:(NSSet *)values;
- (void)removeTweets:(NSSet *)values;
@end
