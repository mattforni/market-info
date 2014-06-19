//
//  MIStatusLabel.m
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/19/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import "MIStatusLabel.h"

#define BORDER 2

@interface MIStatusLabel()

@property UIView *top, *bottom;

@end

@implementation MIStatusLabel



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
        self.text = @"OPEN";
        self.textColor = [MIUIHelper colorFromRGB:60 green:118 blue:61];
        self.backgroundColor = [MIUIHelper colorFromRGB:233 green:240 blue:216];
        _top.backgroundColor = [MIUIHelper colorFromRGB:214 green:233 blue:198];
        _bottom.backgroundColor = [MIUIHelper colorFromRGB:214 green:233 blue:198];
    } else {
        self.text = @"CLOSED";
        self.textColor = [MIUIHelper colorFromRGB:255 green:90 blue:90];
        self.backgroundColor = [MIUIHelper colorFromRGB:255 green:190 blue:190];
        _top.backgroundColor = [MIUIHelper colorFromRGB:255 green:150 blue:150];
        _bottom.backgroundColor = [MIUIHelper colorFromRGB:255 green:150 blue:150];
    }
    [self setNeedsDisplay];
}

@end
