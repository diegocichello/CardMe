//
//  CustomCollectionView.m
//  CardMe
//
//  Created by Diego Cichello on 2/20/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "CustomCollectionView.h"

@interface CustomCollectionView ()

@property BOOL isHighlight;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;



@end

@implementation CustomCollectionView

-(void)tapToChangeBackGround{

    self.isHighlight = !self.isHighlight;

    if (self.isHighlight) {
        self.greenCell.hidden = false;
        self.checkImageView.hidden = false;
        self.imageView.layer.borderColor = [UIColor greenColor].CGColor;
    }
    else{
        self.greenCell.hidden = true;
        self.checkImageView.hidden = true;
        self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

@end
