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
#import "FXImageView.h"

@interface CardReceivedViewController () <UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *receiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *addSomeNotesLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet FXImageView *cardImageView;


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
    self.cardImageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.cardImageView.shadowBlur = 5.0f;
    self.cardImageView.cornerRadius = 10.0f;

    self.textView.delegate = self;
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
- (IBAction)onTapGesture:(id)sender {
    [self.textView resignFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.textView resignFirstResponder];
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

    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)onCancelButtonTapped:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
