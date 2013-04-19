//
//  GameEntity.m
//  GossipLeague
//
//  Created by Oriol Blanc on 26/03/13.
//  Copyright (c) 2013 Gossip. All rights reserved.
//
#import "GameEntity.h"
#import "PlayerEntity.h"

@implementation GameEntity

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ((self = [self init]))
    {
        if ([dictionary isKindOfClass:[NSDictionary class]])
            [self parseDictionary:dictionary];
    }
    
    return self;
}

- (void)parseDictionary:(NSDictionary *)feed
{
    if([[feed allKeys] count] == 0) return;
    
    [feed enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if ([key isEqualToString:@"local"])
        {
            self.local = [[PlayerEntity alloc] initWithDictionary:obj];
        }
        else if ([key isEqualToString:@"visitor"])
        {
            self.visitor = [[PlayerEntity alloc] initWithDictionary:obj];
        }
        else if (([key isEqualToString:@"localGoals"]))
        {
            self.golsLocal = [obj unsignedIntegerValue];
        }
        else if (([key isEqualToString:@"visitorGoals"]))
        {
            self.golsVisitor = [obj unsignedIntegerValue];
        }
        else if (([key isEqualToString:@"playedOn"]))
        {
            self.playedOn = [NSDate dateWithTimeIntervalSince1970:[obj unsignedIntegerValue]];
        }
        
        
    }];
}

@end
