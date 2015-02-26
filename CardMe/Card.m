//
//  Card.m
//  CardMe
//
//  Created by Diego Cichello on 2/17/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "Card.h"
#import "CardInfo.h"
#import "Group.h"
#import "User.h"
#import "CoreDataManager.h"


@implementation Card

@dynamic cardId;
@dynamic cardType;
@dynamic fullName;
@dynamic colorRed;
@dynamic colorBlue;
@dynamic colorGreen;
@dynamic image;
@dynamic fontName;
@dynamic fontSize;
@dynamic notes;
@dynamic isMainUser;
@dynamic group;
@dynamic info;
@dynamic user;


+ (void) retrieveCardsWithBlock:(void (^)(NSArray * array))complete
{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Card"];



    NSArray *result = [[CoreDataManager sharedManager].moc executeFetchRequest:fetch error:nil];

    NSArray *sortedArray;
    sortedArray = [result sortedArrayUsingComparator:^NSComparisonResult(Card *a, Card *b) {

        return [a.info.fullName compare:b.info.fullName];
    }];

    complete(sortedArray);

}

+ (void) retrieveCardsThatContain:(NSString *)string withBlock:(void (^)(NSArray * array))complete
{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Card"];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"fullName beginswith[c] %@",string];

    fetch.predicate = predicate;


    NSArray *result = [[CoreDataManager sharedManager].moc executeFetchRequest:fetch error:nil];

    NSArray *sortedArray;
    sortedArray = [result sortedArrayUsingComparator:^NSComparisonResult(Card *a, Card *b) {

        return [a.info.fullName compare:b.info.fullName];
    }];




    complete(sortedArray);
}



@end
