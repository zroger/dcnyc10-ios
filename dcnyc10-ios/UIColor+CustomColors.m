//
//  UIColor+CustomColors.m
//  dcnyc10-ios
//
//  Created by Roger Lopez on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)

+ (UIColor *)customRedColor 
{
    return [UIColor colorWithRed:194/255.0 green:71/255.0 blue:33/255.0 alpha:1.0];
}

+ (UIColor *)customBlueColor
{
    return [UIColor colorWithRed:30/255.0 green:49/255.0 blue:64/255.0 alpha:1.0];
}

+ (UIColor *)customYellowColor
{
    return [UIColor colorWithRed:255/255.0 green:177/255.0 blue:55/255.0 alpha:1.0];
}

+ (UIColor *)customLightBrownPatternImage
{
    UIImage *tileImage = [UIImage imageNamed:@"bg-repeat_light.png"];
    return [UIColor colorWithPatternImage:tileImage];
}

@end
