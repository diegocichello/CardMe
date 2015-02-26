//
//  MainViewController.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "MainViewController.h"
#import "Card.h"
#import "CardInfo.h"
#import "iCarousel.h"
#import "FXImageView.h"
#import "ProfileViewController.h"
#import "MainViewCollectionCell.h"
#import "MainViewTableCell.h"
#import "LinkedinInfo.h"

@interface MainViewController () <UIGestureRecognizerDelegate,iCarouselDataSource,iCarouselDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *tabView;
@property int index;
@property (weak, nonatomic) IBOutlet iCarousel *cardCarousel;
@property NSMutableArray *cardArray;
@property NSMutableArray *searchedArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;



@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.hidesBarsWhenKeyboardAppears = true;
    self.navigationItem.hidesBackButton = true;

    self.navigationController.navigationBarHidden = true;

    self.cardCarousel.bounces = false;

    self.cardCarousel.type = iCarouselTypeCoverFlow2;
    self.tabView.layer.borderWidth = 2.0f;
    self.tabView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.tabView.layer.cornerRadius = 10.0f;
    self.tabView.clipsToBounds = true;





    //unselected icon
    //item0.image = [[UIImage imageNamed:@"white30x30"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //selected icon
    //item0.selectedImage = [UIImage imageNamed:@"white30x30"];


    









}
- (IBAction)onTapGesture:(id)sender
{
    [self.searchBar resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true]; 
    self.cardArray = [NSMutableArray new];
    self.searchedArray = [NSMutableArray new];
    [Card retrieveCardsWithBlock:^(NSArray *array) {
        self.cardArray = [array mutableCopy];
        self.searchedArray = [array mutableCopy];

        if (self.cardArray.count <3)
        {
            self.cardCarousel.type = iCarouselTypeCoverFlow;

        }
        else
        {
            self.cardCarousel.type = iCarouselTypeRotary;
        }

        [self.cardCarousel reloadData];
    }];

   


}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

    if ([searchText isEqualToString:@""])
    {
        self.searchedArray = self.cardArray;

    }
    else
    {
    [Card retrieveCardsThatContain:searchText withBlock:^(NSArray *array) {


        self.searchedArray = [array mutableCopy];

        if (self.searchedArray.count <3)
        {
            self.cardCarousel.type = iCarouselTypeCoverFlow;

        }
        else
        {
            self.cardCarousel.type = iCarouselTypeRotary;
        }


    }];
    }

    [self.collectionView reloadData];
    [self.tableView reloadData];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    self.index = (int)index;
    [self performSegueWithIdentifier:@"ProfileSegue" sender:self];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.index = (int)indexPath.row;
    [self performSegueWithIdentifier:@"ProfileSegue" sender:self];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.index = (int)indexPath.row;
    [self performSegueWithIdentifier:@"ProfileSegue" sender:self];
}
- (IBAction)segmentChanged:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0)
    {
        self.collectionView.hidden = true;
        self.tableView.hidden = true;
        self.cardCarousel.hidden = false;
        self.searchBar.hidden = true;
    }
    else if (segment.selectedSegmentIndex ==1)
    {
        self.collectionView.hidden = false;
        self.tableView.hidden = true;
        self.cardCarousel.hidden = true;
        self.searchBar.hidden = false;
    }
    else if (segment.selectedSegmentIndex ==2)
    {
        self.collectionView.hidden = true;
        self.tableView.hidden = false;
        self.cardCarousel.hidden= true;
        self.searchBar.hidden = false;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ProfileSegue"])
    {

        ProfileViewController *profileVC = segue.destinationViewController;
        profileVC.card = [self.cardArray objectAtIndex:(NSUInteger)self.index];
    }

}


#pragma mark Carousel Methods

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{



    //create new view if no view is available for recycling
    if (view == nil)
    {
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width -20, self.view.frame.size.width-20)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.4f;
        imageView.reflectionAlpha = 0.1f;
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


#pragma mark Table View Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    Card *card = [self.searchedArray objectAtIndex:indexPath.row];
    cell.headlineLabel.text = card.info.headline;
    cell.fullNameLabel.text = card.info.fullName;
    cell.profilePicture.image = [UIImage imageWithData:card.info.linkedininfo.pictureSmall];
    cell.profilePicture.layer.cornerRadius = 30;
    cell.profilePicture.clipsToBounds = true;


    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchedArray.count;
}

#pragma mark Collection View Methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Card *card = [self.searchedArray objectAtIndex:indexPath.row];

    cell.profilePicture.image = [UIImage imageWithData:card.info.linkedininfo.pictureSmall];
    cell.profilePicture.layer.cornerRadius = 40;
    cell.profilePicture.clipsToBounds = true;
    cell.firstName.text = card.info.linkedininfo.firstName;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchedArray.count;

}







@end
