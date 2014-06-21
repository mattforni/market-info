//
//  MIOpenLabel.m
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/19/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import "MIOpenLabel.h"

#define BORDER 0.5

@interface MIOpenLabel()

@property UIView *top, *bottom;

@end

@implementation MIOpenLabel



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        CGSize size = self.bounds.size;
        UIColor *borderColor = [UIColor whiteColor];
        
        _top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, BORDER)];
        _top.opaque = YES;
        _top.backgroundColor = borderColor;
        _top.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_top];
        
        _bottom = [[UIView alloc] initWithFrame:CGRectMake(0, size.height - BORDER, size.width, BORDER)];
        _bottom.opaque = YES;
        _bottom.backgroundColor = borderColor;
        _bottom.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_bottom];
    }
    return self;
}

- (void)setOpen:(BOOL)open
{
    if (open) {
        self.textColor = [MIUIHelper colorFromRGB:60 green:118 blue:61];
        self.backgroundColor = [MIUIHelper colorFromRGB:233 green:240 blue:216];
        _top.backgroundColor = [MIUIHelper colorFromRGB:60 green:118 blue:61];
        _bottom.backgroundColor = [MIUIHelper colorFromRGB:60 green:118 blue:61];
    } else {
        self.textColor = [MIUIHelper colorFromRGB:160 green:160 blue:160];
        self.backgroundColor = [MIUIHelper colorFromRGB:245 green:245 blue:245];
        _top.backgroundColor = [MIUIHelper colorFromRGB:160 green:160 blue:160];
        _bottom.backgroundColor = [MIUIHelper colorFromRGB:160 green:160 blue:160];
    }
    [self setNeedsDisplay];
}

@end
