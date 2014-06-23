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
        NSString *url = @"http://market-info.herokuapp.com/markets?format=json";
        NSURLSessionDataTask *task = [self.session dataTaskWithURL:[NSURL URLWithString:url]
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSMutableArray *markets = [NSMutableArray array];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            for (id market in json) {
                [markets addObject: [MIMarket initWithJSON:market]];
            }
            self.markets = [NSArray arrayWithArray:markets];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MIMarketsLoaded"
                object:self userInfo:@{@"markets": self.markets}];
        }];
        [task resume];
    }
    return self;
}

- (void)loadMarket:(NSString *)name
{
    NSString *url = [NSString stringWithFormat:@"http://market-info.herokuapp.com/markets/%@?format=json", name];
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MIMarketLoaded"
            object:self userInfo:@{@"market": [MIMarket initWithJSON:json], @"name": name}];
    }];
    [task resume];
}

@end
