//
//  CodSessionSpeaker.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CodSessionSpeaker : NSManagedObject

@property (nonatomic, retain) NSString * ssid;
@property (nonatomic, retain) NSNumber * session_id;
@property (nonatomic, retain) NSNumber * speaker_id;

@end
