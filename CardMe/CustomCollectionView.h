//
//  CustomCollectionView.h
//  CardMe
//
//  Created by Diego Cichello on 2/20/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDTO.h"

@interface CustomCollectionView : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *greenCell;



-(void)tapToChangeBackGround;

@end
