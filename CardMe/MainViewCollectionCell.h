//
//  MainViewCollectionCell.h
//  CardMe
//
//  Created by Diego Cichello on 2/25/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *firstName;

@end
