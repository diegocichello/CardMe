//
//  MainViewController.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "MainViewController.h"
#import "Card.h"
#import "iCarousel.h"
#import "FXImageView.h"
#import "ProfileViewController.h"

@interface MainViewController () <UIGestureRecognizerDelegate,iCarouselDataSource,iCarouselDelegate>

@property int index;
@property (weak, nonatomic) IBOutlet iCarousel *cardCarousel;
@property NSMutableArray *cardArray;


@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [Card retrieveCardsWithBlock:^(NSArray *array) {
        self.cardArray = [array mutableCopy];
        [self.cardCarousel reloadData];
    }];
    self.cardCarousel.type = iCarouselTypeRotary;
    self.cardCarousel.bounces = true;





}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    [Card retrieveCardsWithBlock:^(NSArray *array) {
        self.cardArray = [array mutableCopy];
        [self.cardCarousel reloadData];
    }];
}


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    self.index = (int)index;
    [self performSegueWithIdentifier:@"ProfileSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ProfileViewController *profileVC = segue.destinationViewController;
    profileVC.card = [self.cardArray objectAtIndex:(NSUInteger)self.index];

}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{



    //create new view if no view is available for recycling
    if (view == nil)
    {
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.5f;
        imageView.reflectionAlpha = 0.25f;
        imageView.reflectionGap = 10.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
        imageView.shadowBlur = 5.0f;
        imageView.cornerRadius = 10.0f;
        view = imageView;
    }

    //show placeholder
    //((FXImageView *)view).processedImage = [UIImage imageNamed:@"placeholder.png"];

    //set image
    Card *card = [self.cardArray objectAtIndex:index];
    ((FXImageView *)view).image = [UIImage imageWithData:card.image];

    return view;


}




- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.cardArray.count;
}



@end
