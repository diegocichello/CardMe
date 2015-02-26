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
#import "Card.h"
#import "CardInfo.h"

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
- (IBAction)onTapGesture:(id)sender {
    [self.fullNameTextField resignFirstResponder];
    [self.headlineTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.webURLTextField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    self.fullNameTextField.text = [CoreDataManager sharedManager].currentUser.card.fullName;
    self.headlineTextField.text = [CoreDataManager sharedManager].currentUser.card.info.headline;
    self.addressTextField.text = [CoreDataManager sharedManager].currentUser.card.info.address;
    self.emailTextField.text = [CoreDataManager sharedManager].currentUser.card.info.email;
    self.webURLTextField.text = [CoreDataManager sharedManager].currentUser.card.info.website;
    self.phoneNumberTextField.text = [CoreDataManager sharedManager].currentUser.card.info.contactPhone;

    double size = [[CoreDataManager sharedManager].currentUser.card.fontSize doubleValue];

    [self setAllFonts:[UIFont fontWithName:[CoreDataManager sharedManager].currentUser.card.fontName size:size]];

    float red = [[CoreDataManager sharedManager].currentUser.card.colorRed floatValue];
    float green = [[CoreDataManager sharedManager].currentUser.card.colorGreen floatValue];
    float blue = [[CoreDataManager sharedManager].currentUser.card.colorBlue floatValue];

    [self setCardColor:[UIColor colorWithRed:red green:green blue:blue alpha:1]];
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
    //Get the size of the screen
    [self.fullNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.headlineTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
    [self.webURLTextField resignFirstResponder];

    if ([self.fullNameTextField.text isEqualToString:@""])
    {
        self.fullNameTextField.placeholder = @"";
    }
    if ([self.emailTextField.text isEqualToString:@""])
    {
        self.emailTextField.placeholder = @"";
    }
    if ([self.headlineTextField.text isEqualToString:@""])
    {
        self.headlineTextField.placeholder = @"";
    }
    if ([self.addressTextField.text isEqualToString:@""])
    {
        self.addressTextField.placeholder = @"";
    }
    if ([self.phoneNumberTextField.text isEqualToString:@""])
    {
        self.phoneNumberTextField.placeholder = @"";
    }
    if ([self.webURLTextField.text isEqualToString:@""])
    {
        self.webURLTextField.placeholder = @"";
    }

    CGRect screenRect = [self.cardView bounds];

    //Create a bitmap-based graphics context and make
    //it the current context passing in the screen size
    UIGraphicsBeginImageContext(screenRect.size);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);

    //render the receiver and its sublayers into the specified context
    //choose a view or use the window to get a screenshot of the
    //entire device
    [self.cardView.layer renderInContext:ctx];

    UIImage *cardImage = UIGraphicsGetImageFromCurrentImageContext();

    //End the bitmap-based graphics context
    UIGraphicsEndImageContext();





    

    [CoreDataManager sharedManager].currentUser.card.fontName = self.fullNameTextField.font.fontName;
    [CoreDataManager sharedManager].currentUser.card.fontSize = [NSNumber numberWithDouble:self.fullNameTextField.font.pointSize];

    const CGFloat *colors = CGColorGetComponents(self.fullNameTextField.textColor.CGColor);
    [CoreDataManager sharedManager].currentUser.card.colorRed = [NSNumber numberWithFloat:colors[0]];
    [CoreDataManager sharedManager].currentUser.card.colorGreen = [NSNumber numberWithFloat:colors[1]];
    [CoreDataManager sharedManager].currentUser.card.colorBlue = [NSNumber numberWithFloat:colors[2]];
    [CoreDataManager sharedManager].currentUser.card.isMainUser = @1;

    [CoreDataManager sharedManager].currentUser.card.image = UIImagePNGRepresentation(cardImage);





    [CoreDataManager sharedManager].currentUser.card.fullName = self.fullNameTextField.text;
    [CoreDataManager sharedManager].currentUser.card.info.address = self.addressTextField.text;
    [CoreDataManager sharedManager].currentUser.card.info.fullName = self.fullNameTextField.text;
    [CoreDataManager sharedManager].currentUser.card.info.headline = self.headlineTextField.text;
    [CoreDataManager sharedManager].currentUser.card.info.email = self.emailTextField.text;
    [CoreDataManager sharedManager].currentUser.card.info.contactPhone = self.phoneNumberTextField.text;
    [CoreDataManager sharedManager].currentUser.card.info.website = self.webURLTextField.text;

    [CoreDataManager sharedManager].currentUser.card.info.linkedininfo = [CoreDataManager sharedManager].linkedinInfo;
    
    [[CoreDataManager sharedManager].moc save:nil];

    [self performSegueWithIdentifier:@"MainFeedSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (![segue.identifier isEqualToString:@"MainFeedSegue"])
    {
        FontsViewController *vc = segue.destinationViewController;
        vc.fullName = self.fullNameTextField.text;
        vc.myCardVC = self;
        vc.font = self.font;
    }
}

@end
