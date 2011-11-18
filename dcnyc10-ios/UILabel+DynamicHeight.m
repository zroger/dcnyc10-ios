//
//  UILabel+DynamicHeight.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UILabel+DynamicHeight.h"

@implementation UILabel (DynamicHeight)

// http://stackoverflow.com/questions/446405/adjust-uilabel-height-depending-on-the-text/447065#447065
- (void) sizeWithDynamicHeight
{
    //Calculate the expected size based on the font and linebreak mode of your label
    CGSize maximumLabelSize = CGSizeMake(296,9999);
    
    CGSize expectedLabelSize = [self.text sizeWithFont:self.font 
                                     constrainedToSize:maximumLabelSize 
                                         lineBreakMode:self.lineBreakMode]; 
    
    //adjust the label the the new height.
    CGRect newFrame = self.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.frame = newFrame;
}
@end
