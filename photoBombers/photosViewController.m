//
//  photosViewController.m
//  photoBombers
//
//  Created by Robin Malhotra on 13/10/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "photosViewController.h"
#import <SimpleAuth/SimpleAuth.h>
@interface photosViewController ()
{
    NSURL *location2;
}
@property (nonatomic) NSString *accessToken;
@end

@implementation photosViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    

}

-(void)viewDidLoad
{
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    self.collectionView.alwaysBounceVertical=YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"photo"];
    [self setTitle:@"Photo Bombers"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    //code to move
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    self.accessToken=[userDefaults objectForKey:@"accessToken"];
    if (self.accessToken==nil)
    {
        [SimpleAuth authorize:@"instagram" completion:^(NSDictionary *responseObject, NSError *error)
         {
             NSString *accessToken=responseObject[@"credentials"][@"token"];
             [userDefaults setObject:accessToken forKey:@"accessToken"];
             [userDefaults synchronize];
         }];
    }
    else
    {
        NSLog(@"signed in");
        NSURLSession *session=[NSURLSession sharedSession];
        NSURL *url=[[NSURL alloc]initWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/snow/media/recent?access_token=%@",[userDefaults objectForKey:@"accessToken"]]];
        NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
        NSURLSessionDownloadTask *task=[session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            
            NSData *data=[[NSData alloc]initWithContentsOfURL:location ];
            NSDictionary *responseDictionary=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSArray *photos=[responseDictionary valueForKeyPath:@"data.images.standard_resolution.url"];
            NSLog(@"%@",photos);
        }];
        [task resume];
        
    }

    

}
@end
