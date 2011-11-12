//
//  SessionDetail.h
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodSession.h"

@interface SessionDetail : UIViewController {
}

@property (nonatomic, retain) CodSession *session;
@property (nonatomic, retain) IBOutlet UITextView *titleTextView;
@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@end
