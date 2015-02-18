//
//  CardGenerationViewController.m
//  CardMe
//
//  Created by Diego Cichello on 2/16/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "CardGenerationViewController.h"
#import "User.h"
#import "CoreDataManager.h"
#import "LinkedinInfo.h"
#import "LinkedinPhoneNumber.h"
#import "LinkedinURL.h"
#import "Card.h"
#import "CardInfo.h"

@interface CardGenerationViewController () <UIActionSheetDelegate>


@property (weak, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *headlineTextField;

@property (weak, nonatomic) IBOutlet UITextField *companyAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *webURLTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UILabel *lineBar;
@property (weak, nonatomic) IBOutlet UIView *cardView;


@property CGFloat menuWidth;
@property NSTimeInterval animationTime;


@end



@implementation CardGenerationViewController

- (void) viewDidLoad
{
    [super viewDidLoad];



    CoreDataManager *currentUser = [CoreDataManager sharedManager];
    User *user = currentUser.currentUser;

    self.fullNameTextField.text = [NSString stringWithFormat:@"%@ %@",user.info.firstName, user.info.lastName];
    self.headlineTextField.text = user.info.headline;
    self.emailTextField.text = user.info.email;

    LinkedinPhoneNumber *phoneNumber = [user.info.phoneNumbers allObjects].firstObject;
    self.phoneNumberTextField.text = phoneNumber.phoneNumber;

    LinkedinURL *url = [user.info.urls allObjects].firstObject;
    if (url)
    {
        self.webURLTextField.text = url.url;
    }
    else
    {
        self.webURLTextField.text =@"";
    }
    self.addressTextField.text = @"";

}
- (IBAction)onCollorsButtonTapped:(UIButton *)sender
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"Colors" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *red = [UIAlertAction
                                   actionWithTitle:@"Red"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       [self setAllColors:[UIColor redColor]];

                                   }];
    UIAlertAction *blue = [UIAlertAction
                                    actionWithTitle:@"Blue"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        [self setAllColors:[UIColor blueColor]];
                                    }];
    UIAlertAction *green = [UIAlertAction
                                  actionWithTitle:@"Green"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction *action)
                                  {
                                      [self setAllColors:[UIColor greenColor]];

                                  }];
    UIAlertAction *orange = [UIAlertAction
                                   actionWithTitle:@"Orange"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       [self setAllColors:[UIColor orangeColor]];

                                   }];
    UIAlertAction *gray = [UIAlertAction
                                      actionWithTitle:@"Gray"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction *action)
                                      {
                                          [self setAllColors:[UIColor grayColor]];

                                      }];
    UIAlertAction *black = [UIAlertAction
                                actionWithTitle:@"Black"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                {
                                    [self setAllColors:[UIColor blackColor]];

                                }];








    
    [alertcontroller addAction:red];
    [alertcontroller addAction:blue];
    [alertcontroller addAction:gray];
    [alertcontroller addAction:orange];
    [alertcontroller addAction:green];
    [alertcontroller addAction:black];
    
    
    
    [self presentViewController:alertcontroller animated:YES completion:^{
        nil;
    }];
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    [actionSheet.subviews enumerateObjectsUsingBlock:^(id _currentView, NSUInteger idx, BOOL *stop) {
        if ([_currentView isKindOfClass:[UIButton class]]) {
            [((UIButton *)_currentView).titleLabel setFont:[UIFont boldSystemFontOfSize:25.f]];
            // OR
            //[((UIButton *)_currentView).titleLabel setFont:[UIFont fontWithName:@"Exo2-SemiBold" size:17]];
        }
    }];
}
- (IBAction)continueButtonTapped:(UIButton *)sender
{
    //Get the size of the screen
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

    for (int i=0;i<10;i++)
    {

    Card *card  = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:[CoreDataManager sharedManager].moc];

    [CoreDataManager sharedManager].currentUser.card = card;

    card.fontName = self.fullNameTextField.font.fontName;
    card.fontSize = [NSNumber numberWithDouble:self.fullNameTextField.font.pointSize];

    const CGFloat *colors = CGColorGetComponents(self.fullNameTextField.textColor.CGColor);
    card.colorRed = [NSNumber numberWithFloat:colors[0]];
    card.colorGreen = [NSNumber numberWithFloat:colors[1]];
    card.colorBlue = [NSNumber numberWithFloat:colors[2]];
    card.isMainUser = @1;

    card.image = UIImagePNGRepresentation(cardImage);


    CardInfo *cardInfo = [NSEntityDescription insertNewObjectForEntityForName:@"CardInfo" inManagedObjectContext:[CoreDataManager sharedManager].moc];

    card.info = cardInfo;

    card.info.address = self.addressTextField.text;
    card.info.fullName = self.fullNameTextField.text;
    card.info.headline = self.headlineTextField.text;
    card.info.email = self.emailTextField.text;
    card.info.contactPhone = self.phoneNumberTextField.text;
    card.info.website = self.webURLTextField.text;
    }


    [self performSegueWithIdentifier:@"MainFeedSegue" sender:self];




}




- (IBAction)onFontsButtonTapped:(id)sender
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"Fonts" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *avenirAction = [UIAlertAction
                               actionWithTitle:@"Avenir"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [self setAllFonts:[UIFont fontWithName:@"Avenir" size:14]];
                                   
                               }];
    UIAlertAction *courierAction = [UIAlertAction
                               actionWithTitle:@"Courier New"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [self setAllFonts:[UIFont fontWithName:@"Courier New" size:14]];

                               }];
    UIAlertAction *didotAction = [UIAlertAction
                               actionWithTitle:@"Didot"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [self setAllFonts:[UIFont fontWithName:@"Didot" size:14]];

                               }];
    UIAlertAction *futureAction = [UIAlertAction
                               actionWithTitle:@"Future"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [self setAllFonts:[UIFont fontWithName:@"Future" size:12]];

                               }];
    UIAlertAction *helveticaAction = [UIAlertAction
                               actionWithTitle:@"Helvetica"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [self setAllFonts:[UIFont fontWithName:@"Helvetica" size:14]];

                               }];









    [alertcontroller addAction:avenirAction];
    [alertcontroller addAction:courierAction];
    [alertcontroller addAction:didotAction];
    [alertcontroller addAction:futureAction];
    [alertcontroller addAction:helveticaAction];




    [self presentViewController:alertcontroller animated:YES completion:^{
        nil;
    }];
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

- (void) setAllColors:(UIColor *)color
{
    [self.fullNameTextField setTextColor:color];
    [self.lineBar setTextColor:color];


}
@end
