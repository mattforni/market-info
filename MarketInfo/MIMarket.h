//
//  MIMarket.h
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/18/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIMarket : NSObject

+ (id)initFromJson:(NSDictionary *)json;
+ (id)initWithNameAndTimeZone:(NSString *)name timeZone:(NSString *)timeZone;

@property NSString* name;
@property BOOL open;
@property NSString* timeZone;

@end
