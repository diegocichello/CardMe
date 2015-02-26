//
//  MyCardViewController.m
//  CardMe
//
//  Created by Diego Cichello on 2/24/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "MyCardViewController.h"
#import "FontsViewController.h"
#import "CoreDataManager.h"

@interface MyCardViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UITextField *headlineTextField;

@property NSMutableArray *colorsArray;

@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *webURLTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *cardView;


@end

@implementation MyCardViewController


- (void) viewDidLoad
{
    [super viewDidLoad];

    self.colorsArray = [NSMutableArray new];
    NSString *fontName = [CoreDataManager sharedManager].currentUser.card.fontName;
    self.font = [UIFont fontWithName:fontName size:13];
    self.imageView.image = [UIImage imageWithData:[CoreDataManager sharedManager].currentUser.info.pictureSmall];
    self.imageView.layer.cornerRadius =25.0f;
    self.imageView.clipsToBounds = true;






    for (UIButton *button in self.buttons)
    {
        button.layer.cornerRadius = 3.0f;

        button.clipsToBounds = true;
        [self.colorsArray addObject:button.backgroundColor];

    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    [self setAllFonts:self.font];
}
- (IBAction)colorButtonTapped:(UIButton *)sender {

    [self setCardColor:sender.backgroundColor];
}

- (void) setAllFonts:(UIFont *)font
{
    [self.fullNameTextField setFont:font];
    [self.headlineTextField setFont:font];
    [self.addressTextField setFont:font];
    [self.emailTextField setFont:font];
    [self.webURLTextField setFont:font];
    [self.phoneNumberTextField setFont:font];

}

- (void) setCardColor:(UIColor *)color
{
    [self.fullNameTextField setTextColor:color];
    [self.lineView setBackgroundColor:color];

    
}

- (IBAction)onSaveButtonTapped:(id)sender
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FontsViewController *vc = segue.destinationViewController;
    vc.fullName = self.fullNameTextField.text;
    vc.myCardVC = self;
    vc.font = self.font;
}

@end
