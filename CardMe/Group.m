//
//  Group.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "Group.h"
#import "Card.h"


@implementation Group

@dynamic name;
@dynamic card;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    if (self)
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.card = [aDecoder decodeObjectForKey:@"card"];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.card forKey:@"card"];
}



@end
