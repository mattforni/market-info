//
//  MIUIHelper.h
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/19/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIUIHelper : NSObject

+ (UIColor *)colorFromRGB:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b;
+ (void)padView:(UIView *)view padding:(UIEdgeInsets)insets;

@end
