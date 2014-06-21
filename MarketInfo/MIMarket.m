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
            // TODO implement closes at
        } else {
            // TODO update to use 'opens_at' instead of 'next_open'
            NSMutableString *openDate = [[NSMutableString alloc] init];
            [openDate appendString:json[@"next_open"]];
            [openDate appendString:@" +0400"];
            NSLog(@"%@", openDate);
            // TODO update server to include timezone offset
            market.opensAt = [dateFormat dateFromString:openDate];
            NSLog(@"%@", market.opensAt);
        }
        market.timeZone = json[@"time_zone"];
    }
    return market;
}

@end
