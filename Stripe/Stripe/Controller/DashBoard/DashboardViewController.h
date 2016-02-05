//
//  DashboardViewController.h
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    __weak IBOutlet UITableView *tblView;
    __weak IBOutlet UIView *sectionView1;
    __weak IBOutlet UIView *sectionView2;
}
@property(nonatomic,strong)NSString *currency;
+(DashboardViewController *)initViewController;
@end
