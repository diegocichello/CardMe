//
//  Card.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "Card.h"
#import "User.h"


@implementation Card

@dynamic type;
@dynamic color1;
@dynamic color2;
@dynamic color3;
@dynamic color4;
@dynamic color5;
@dynamic cardId;
@dynamic font1;
@dynamic font2;
@dynamic font3;
@dynamic font4;
@dynamic font5;
@dynamic isMainUser;
@dynamic user;
@dynamic group;


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.type = [coder decodeObjectForKey:@"type"];
        self.color1 = [coder decodeObjectForKey:@"color1"];
        self.color2 = [coder decodeObjectForKey:@"color2"];
        self.color3 = [coder decodeObjectForKey:@"color3"];
        self.color4 = [coder decodeObjectForKey:@"color4"];
        self.color5 = [coder decodeObjectForKey:@"color5"];
        self.cardId = [coder decodeObjectForKey:@"cardId"];
        self.font1 = [coder decodeObjectForKey:@"font1"];
        self.font2 = [coder decodeObjectForKey:@"font2"];
        self.font3 = [coder decodeObjectForKey:@"font3"];
        self.font4 = [coder decodeObjectForKey:@"font4"];
        self.font5 = [coder decodeObjectForKey:@"font5"];
        self.group = [coder decodeObjectForKey:@"group"];
        //self.user = [coder decodeObjectForKey:@"user"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.color1 forKey:@"color1"];
    [encoder encodeObject:self.color2 forKey:@"color2"];
    [encoder encodeObject:self.color3 forKey:@"color3"];
    [encoder encodeObject:self.color4 forKey:@"color4"];
    [encoder encodeObject:self.color5 forKey:@"color5"];
    [encoder encodeObject:self.cardId forKey:@"cardId"];
    [encoder encodeObject:self.font1 forKey:@"font1"];
    [encoder encodeObject:self.font2 forKey:@"font2"];
    [encoder encodeObject:self.font3 forKey:@"font3"];
    [encoder encodeObject:self.font4 forKey:@"font4"];
    [encoder encodeObject:self.font5 forKey:@"font5"];
    [encoder encodeObject:self.group forKey:@"group"];


}



@end
