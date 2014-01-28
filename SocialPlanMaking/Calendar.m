//
//  Calendar.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/28/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "Calendar.h"

@interface Calendar ()

@end

@implementation Calendar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    //NSString *searchTerm = self.searches[section];
    //return [self.searchResults[searchTerm] count];
    return 12;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    //return [self.searches count];
    return 12;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Time" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if(indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
                cell.
                break;
                
            default:
                break;
        }
    }
    
    
    return cell;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    NSLog(@"did touch cell");
    NSLog(@"index: %i",indexPath.row);
    NSLog(@"section: %i",indexPath.section);
    
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
    
}

// 1
//tells you the size of a given cell
//the return type is CG
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSString *searchTerm = self.searches[indexPath.section]; FlickrPhoto *photo =
    //self.searchResults[searchTerm][indexPath.row];
    // 2
    //CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
    //retval.height += 35; retval.width += 35;
    CGSize retval = CGSizeMake(20, 20);
    return retval;
}

// 3 returns the spacing between the cells, headers, and footers.
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(2, 2, 2, 2);
}


@end
