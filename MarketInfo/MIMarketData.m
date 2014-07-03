//
//  MIMarketData.m
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/18/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import "MIMarketData.h"

@interface MIMarketData()

@property NSString *marketURL, *marketsURL;
@property NSURLSession *session;

@end

@implementation MIMarketData

static MIMarketData *instance;

+ (MIMarketData *)instance
{
    if (instance == nil) { instance = [[super alloc] init]; }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _marketURL = @"http://market-info.herokuapp.com/markets/%@?format=json";
        _marketsURL = @"http://market-info.herokuapp.com/markets?format=json";
        _session = [NSURLSession sharedSession];

        [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(loadMarket:) name:@"LoadMarket" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadMarket:(NSNotification *)notification
{
    NSString *name = notification.userInfo[@"name"];
    if (name == nil || name.length == 0) { return; }

    NSString *url = [NSString stringWithFormat: _marketURL, name];
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MarketLoaded"
            object:self userInfo:@{@"market": [MIMarket initWithJSON:json], @"name": name}];
    }];

    [task resume];
}

- (void)loadMarkets
{
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:[NSURL URLWithString:_marketsURL]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSMutableArray *markets = [NSMutableArray array];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        for (id market in json) { [markets addObject: [MIMarket initWithJSON:market]]; }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MarketsLoaded"
            object:self userInfo:@{@"markets": [NSArray arrayWithArray:markets]}];
    }];
    [task resume];
}

@end
