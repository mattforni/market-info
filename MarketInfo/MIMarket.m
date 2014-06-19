//
//  MIMarket.m
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/18/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import "MIMarket.h"

@implementation MIMarket

+ (id)initFromJson:(NSDictionary *)json
{
    MIMarket *market = [[MIMarket alloc] init];
    if (market) {
        market.name = json[@"name"];
        market.open = [json[@"is_open"] boolValue];
        market.timeZone = json[@"time_zone"];
    }
    return market;
}

+ (id)initWithNameAndTimeZone:(NSString *)name timeZone:(NSString *)timeZone
{
    MIMarket *market = [[MIMarket alloc] init];
    if (market) {
        market.name = name;
        market.timeZone = timeZone;
    }
    return market;
}

@end
