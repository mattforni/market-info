//
//  MIMarket.m
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/18/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import "MIMarket.h"

@implementation MIMarket

+ (id)initWithJSON:(NSDictionary *)json
{
    MIMarket *market = [[MIMarket alloc] init];
    if (market) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];

        market.name = json[@"name"];
        market.open = [json[@"is_open"] boolValue];
        if (market.open) {
            market.closesAt = [dateFormat dateFromString:json[@"closes_at"]];
        } else {
            market.opensAt = [dateFormat dateFromString:json[@"opens_at"]];
        }
        market.timeZone = json[@"time_zone"];
    }
    return market;
}

@end
