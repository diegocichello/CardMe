//
//  CardDTO.m
//  CardMe
//
//  Created by Gustavo Couto on 2015-02-13.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "CardDTO.h"
#import "CardInfo.h"
#import "LinkedinInfo.h"

@implementation CardDTO


//@dynamic fonts;
//@dynamic colors;
//@dynamic fullName;
//@dynamic email;
//@dynamic headline;
//@dynamic jobs;
//@dynamic skills;
//@dynamic address;
//@dynamic education;


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.fonts = [aDecoder decodeObjectForKey:@"fonts"];
        self.colors = [aDecoder decodeObjectForKey:@"colors"];
        self.fullName = [aDecoder decodeObjectForKey:@"fullName"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.headline = [aDecoder decodeObjectForKey:@"headline"];
        self.jobs = [aDecoder decodeObjectForKey:@"jobs"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.skills = [aDecoder decodeObjectForKey:@"skills"];
        self.education = [aDecoder decodeObjectForKey:@"education"];
        self.phoneNumber = [aDecoder decodeObjectForKey:@"phone"];
        
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fonts forKey:@"fonts"];
    [aCoder encodeObject:self.colors forKey:@"colors"];
    [aCoder encodeObject:self.fullName forKey:@"fullName"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.headline forKey:@"headline"];
    [aCoder encodeObject:self.jobs forKey:@"jobs"];
    [aCoder encodeObject:self.skills forKey:@"skills"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.education forKey:@"education"];
    [aCoder encodeObject:self.phoneNumber forKey:@"phone"];


}


- (instancetype)initWithManagedObject: (Card *)card
{
    self = [super init];
    if (self)
    {
        self.fonts = [NSArray new];
        self.fonts= [NSArray arrayWithObjects:card.font1,card.font2,card.font3,card.font4,card.font5, nil];
        self.colors = [NSArray arrayWithObjects:card.color1,card.font2,card.font3,card.font4,card.font5, nil];
        self.fullName = card.info.fullName;
        self.email = card.info.email;
        self.headline = card.info.headline;
        self.address = card.info.address;
        self.jobs = [[NSArray alloc]init];
        self.skills = [[NSArray alloc]init];
        self.education = [[NSArray alloc]init];
        self.phoneNumber = card.info.contactPhone;
    }
    return self;

}

@end
