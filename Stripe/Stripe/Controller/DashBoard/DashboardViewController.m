//
//  DashboardViewController.m
//  Stripe
//
//  Created by Samir on 2/4/16.
//  Copyright © 2016 Samir. All rights reserved.
//

#import "DashboardViewController.h"
#import "CAccount.h"
#import "AppDelegate.h"
#import "PaymentViewController.h"
#import "AccountManager.h"
#import "ProductCell.h"
#import "ImageCell.h"
@interface DashboardViewController ()
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@end

@implementation DashboardViewController

+(DashboardViewController *)initViewController{
    DashboardViewController *controller = [[DashboardViewController alloc]initWithNibName:@"DashboardViewController" bundle:nil];
    controller.title = @"Products";
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 25,25)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(userDidLogout)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mainButton =[[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem =mainButton;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(void)userDidLogout{
    [[AppDelegate appDelegate]logout];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return sectionView1;
    }else if (section == 1){
        return sectionView2;
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ImageIdentifier";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell =  (ProductCell *) currentObject;
                break;
            }
        }
        [cell setCollectionViewDataSourceDelegate:self indexPath:nil];
        NSInteger index = cell.collectionView.tag;
        cell.isRead = NO;
        CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
        [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
        [cell.collectionView reloadData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

}

    return cell;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    [searchBar setShowsCancelButton:YES animated:YES];
}


-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    //This'll Hide The cancelButton with Animation
    [self.view endEditing:YES];
    [searchBar setShowsCancelButton:NO animated:YES];
    //remaining Code'll go here
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:@"img_placeholder.png"];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    PaymentViewController *controller = [PaymentViewController initViewController];
    [self.navigationController pushViewController:controller animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
