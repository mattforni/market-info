//
//  MIMarketData.h
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/18/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIMarket.h"

@interface MIMarketData : NSObject

- (MIMarket*)getMarket:(NSString *)name;

@end
