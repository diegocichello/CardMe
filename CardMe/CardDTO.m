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
#import "User.h"

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
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.phoneNumber = [aDecoder decodeObjectForKey:@"phone"];
        self.cardImage = [aDecoder decodeObjectForKey:@"cardImage"];
        self.shouldSendCard = [aDecoder decodeBoolForKey:@"flag"];
        self.information = [aDecoder decodeDataObject];
        
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
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.phoneNumber forKey:@"phone"];
    [aCoder encodeObject:self.cardImage forKey:@"cardImage"];
    [aCoder encodeBool:self.shouldSendCard forKey:@"flag"];
    


}


- (instancetype)initWithManagedObject: (Card *)card
{
    self = [super init];
    if (self)
    {
        self.fonts = [NSArray new];
        self.fonts= [NSArray arrayWithObjects:card.fontName,card.fontSize, nil];
        self.colors = [NSArray arrayWithObjects:card.colorRed,card.colorGreen,card.colorBlue,nil];
        self.fullName = card.info.fullName;
        self.email = card.info.email;
        self.headline = card.info.headline;
        self.address = card.info.address;
        self.cardImage = card.image;
        self.phoneNumber = card.info.contactPhone;
        self.information = card.user.information;
        self.shouldSendCard = false;
    }
    return self;

}

@end
