//
//  ProductCell.h
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ProductCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";
@interface ProductCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDataSource>


@property(nonatomic,strong) ProductCollectionView *collectionView;
@property (nonatomic, assign) BOOL isRead;
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;;
@end
