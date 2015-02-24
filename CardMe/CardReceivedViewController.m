//
//  CardReceivedViewController.m
//  CardMe
//
//  Created by Diego Cichello on 2/19/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "CardReceivedViewController.h"
#import "Card.h"
#import "CardInfo.h"
#import "LinkedinInfo.h"
#import "CoreDataManager.h"

@interface CardReceivedViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *receiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *addSomeNotesLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addNotesLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addNotesRC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldRC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonsLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonsRC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *receiveCardLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *receiveCardRC;

@end

@implementation CardReceivedViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.cardImageView.image = [UIImage imageWithData:self.dto.cardImage];


}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];


    self.receiveCardLC.constant -= self.view.bounds.size.width;
    self.receiveCardRC.constant += self.view.bounds.size.width;


    self.addNotesLC.constant -= self.view.bounds.size.width;
    self.addNotesRC.constant += self.view.bounds.size.width;

    self.textFieldLC.constant -= self.view.bounds.size.width;
    self.textFieldRC.constant += self.view.bounds.size.width;

    self.buttonsLC.constant -= self.view.bounds.size.width;
    self.buttonsRC.constant += self.view.bounds.size.width;


    self.cardImageView.alpha = 0.0;


}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];

    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.receiveCardRC.constant -= self.view.bounds.size.width;
        self.receiveCardLC.constant += self.view.bounds.size.width;
        [self.view layoutIfNeeded];
    } completion:nil];

    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.addNotesRC.constant -= self.view.bounds.size.width;
        self.addNotesLC.constant += self.view.bounds.size.width;
        [self.view layoutIfNeeded];
    } completion:nil];

    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.textFieldRC.constant -= self.view.bounds.size.width;
        self.textFieldLC.constant += self.view.bounds.size.width;
        [self.view layoutIfNeeded];
    } completion:nil];

    [UIView animateWithDuration:0.5 delay:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.buttonsRC.constant -= self.view.bounds.size.width;
        self.buttonsLC.constant += self.view.bounds.size.width;
        [self.view layoutIfNeeded];
    } completion:nil];





    [UIView transitionWithView:self.cardImageView duration:0.5 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationTransitionCurlDown animations:^{
        self.cardImageView.alpha = 1.0;
    } completion:^(BOOL finished) {

    }];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.cardImageView cache:YES];

    [UIView commitAnimations];

    
}
- (IBAction)onOutsideOfText:(UIButton *)sender
{
    [self resignFirstResponder];
}

- (IBAction)onSaveButtonTapped:(UIButton *)sender {


    NSDictionary * testDict = [NSKeyedUnarchiver unarchiveObjectWithData:self.dto.information];
    // CREATE NEW USER

    [LinkedinInfo saveDictionary:testDict];

    Card *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:[CoreDataManager sharedManager].moc];


    card.fontName = self.dto.fonts[0];
    card.fontSize = self.dto.fonts[1];
    card.colorRed = self.dto.colors[0];
    card.colorGreen = self.dto.colors[1];
    card.colorBlue = self.dto.colors[2];
    card.image = self.dto.cardImage;
    card.notes = self.textView.text;

    CardInfo *cardInfo = [NSEntityDescription insertNewObjectForEntityForName:@"CardInfo" inManagedObjectContext:[CoreDataManager sharedManager].moc];

    cardInfo.email = self.dto.email;
    cardInfo.address = self.dto.address;
    cardInfo.contactPhone = self.dto.phoneNumber;
    cardInfo.fullName = self.dto.fullName;
    cardInfo.headline = self.dto.headline;



    [card setInfo:cardInfo];
    [cardInfo setLinkedininfo:[CoreDataManager sharedManager].linkedinInfo];
    
    [self performSegueWithIdentifier:@"MainSegue" sender:self];
}

- (IBAction)onCancelButtonTapped:(id)sender {
}

@end
