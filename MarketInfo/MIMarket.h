//
//  MIMarket.h
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/18/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIMarket : NSObject

+ (id)initWithJSON:(NSDictionary *)json;

@property NSDate *closesAt, *opensAt;
@property NSString *name;
@property BOOL open;
@property NSString *timeZone;

@end
