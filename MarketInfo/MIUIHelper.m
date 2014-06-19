//
//  MIUIHelper.m
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/19/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import "MIUIHelper.h"

@implementation MIUIHelper

+ (UIColor *)colorFromRGB:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

+ (void)padView:(UIView *)view padding:(UIEdgeInsets)insets
{
    CGPoint origin = view.frame.origin;
    CGSize size = view.frame.size;
    [view setFrame:CGRectMake(origin.x, origin.y,
            size.width+insets.left+insets.right,
            size.height+insets.top+insets.bottom)];
}

@end
