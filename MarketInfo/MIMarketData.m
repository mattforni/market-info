//
//  MIMarketData.m
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/18/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import "MIMarketData.h"

const NSString *MI_URL = @"http://market-info.herokuapp.com/%@?format=json";

@interface MIMarketData()

@property NSArray *markets;
@property NSURLSession *session;

@end

@implementation MIMarketData

- (id)init
{
    self = [super init];
    if (self) {
        // Initialize variables
        self.session = [NSURLSession sharedSession];
        self.markets = [NSArray array];
        
        // Retrieve all available markets
        NSString *url = [NSString stringWithFormat:@"http://market-info.herokuapp.com/%@?format=json", @"markets"];
        NSURLSessionDataTask *task = [self.session dataTaskWithURL:[NSURL URLWithString:url]
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSMutableArray *markets = [NSMutableArray array];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            for (id market in json) {
                [markets addObject: [MIMarket initWithNameAndTimeZone:market[@"name"] timeZone:market[@"time_zone"]]];
            }
            self.markets = [NSArray arrayWithArray:markets];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MIMarketsLoaded"
                object:self userInfo:@{@"markets": self.markets}];
        }];
        [task resume];
    }
    return self;
}

- (MIMarket *)getMarket:(NSString *)name
{
    MIMarket *market = [[MIMarket alloc] init];
    market.name = name;
    market.timeZone = @"America/New York";
    return market;
}

@end
