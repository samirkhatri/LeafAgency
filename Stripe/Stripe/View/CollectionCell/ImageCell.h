//
//  ImageCell.h
//  EventApp
//
//  Created by Samir Khatri on 9/7/15.
//  Copyright (c) 2015 Samir Khatri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell
{
    IBOutlet UIImageView *_imgView;
    IBOutlet UIButton *_btnDestroy;
}
@property(nonatomic,retain)UIImageView *imgView;
@property(nonatomic,retain)UIButton *btnDestroy;
@end
