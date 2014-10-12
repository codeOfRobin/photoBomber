//
//  photosViewController.m
//  photoBombers
//
//  Created by Robin Malhotra on 13/10/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "photosViewController.h"

@interface photosViewController ()

@end

@implementation photosViewController

-(instancetype) init
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(106, 106);
    layout.minimumInteritemSpacing=1;
    layout.minimumLineSpacing=1;
    return (self=[super initWithCollectionViewLayout:layout]);
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor lightGrayColor]];
    return cell;
}


-(void)viewDidLoad
{
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    self.collectionView.alwaysBounceVertical=YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"photo"];
    [self setTitle:@"Photo Bombers"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];

}
@end
