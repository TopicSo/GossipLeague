//
//  GameEntity.m
//  GossipLeague
//
//  Created by Oriol Blanc on 26/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//
#import "GameEntity.h"
#import "PlayerEntity.h"
#import <NSValueTransformer+MTLPredefinedTransformerAdditions.h>
#import "MTLValueTransformer.h"

@implementation GameEntity

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"local": @"local",
             @"visitor": @"visitor",
             @"golsLocal": @"localGoals",
             @"golsVisitor": @"visitorGoals",
             @"playedOn": @"playedOn",
             @"localPointsChange": @"localPointsChange",
             @"visitorPointsChange": @"visitorPointsChange"
             };
}

+ (NSValueTransformer *)localJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PlayerEntity class]];
}

+ (NSValueTransformer *)visitorJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PlayerEntity class]];
}


+ (NSValueTransformer *)playedOnJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NSDate dateWithTimeIntervalSince1970:[str longLongValue]];
    } reverseBlock:^(NSDate *date) {
        return @([date timeIntervalSince1970]);
    }];
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

- (NSString *)stringLocalPointsChange
{
    return [NSString stringWithFormat:@"%.0f", self.localPointsChange];
}

- (NSString *)stringVisitorPointsChange
{
    return [NSString stringWithFormat:@"%.0f", self.visitorPointsChange];
}

#pragma mark - Utils

- (GameResult)gameResult
{
    if (self.golsLocal > self.golsVisitor) {
        return GameResultLocalWins;
    } else if (self.golsLocal < self.golsVisitor) {
        return GameResultVisitorWins;
    }
    
    return GameResultDraw;
}

@end
