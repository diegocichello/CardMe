//
//  MainViewTableCell.h
//  CardMe
//
//  Created by Diego Cichello on 2/25/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@end
