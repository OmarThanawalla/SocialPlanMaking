//
//  Calendar.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/28/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "Calendar.h"
#import "DateCell.h"

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
    
    UISwipeGestureRecognizer * swipeMeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipe:)];
    swipeMeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.collectionView addGestureRecognizer:swipeMeDown];
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
    
    DateCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Time" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    if(indexPath.section == 0)
    {
        switch (indexPath.row) {
//            case 0:
//                cell.text.text = @"12PM";
//                break;
            case 1:
                cell.text.text = @"1PM";
                break;
            case 2:
                cell.text.text = @"2PM";
                break;
            case 3:
                cell.text.text = @"3PM";
                break;
            case 4:
                cell.text.text = @"4PM";
                break;
            case 5:
                cell.text.text = @"5PM";
                break;
            case 6:
                cell.text.text = @"6PM";
                break;
            case 7:
                cell.text.text = @"7PM";
                break;
            case 8:
                cell.text.text = @"8PM";
                break;
            case 9:
                cell.text.text = @"9PM";
                break;
            case 10:
                cell.text.text = @"10PM";
                break;
            case 11:
                cell.text.text = @"11PM";
                break;
            case 12:
                cell.text.text = @"12AM";
                break;
                
                
            default:
                break;
        }
    }
    if (indexPath.row == 0) {
        switch (indexPath.section) {
            
            case 1:
                cell.text.text = @"M";
                break;
            case 2:
                cell.text.text = @"Tu";
                break;
            case 3:
                cell.text.text = @"W";
                break;
            case 4:
                cell.text.text = @"Th";
                break;
            case 5:
                cell.text.text = @"F";
                break;
            case 6:
                cell.text.text = @"Sa";
                break;
            case 7:
                cell.text.text = @"Sun";
                break;
            case 8:
                cell.text.text = @"";
                break;
            case 9:
                cell.text.text = @"";
                break;
            case 10:
                cell.text.text = @"";
                break;
            case 11:
                cell.text.text = @"";
                break;
            case 12:
                cell.text.text = @"";
                break;
        
        
            default:
                break;
        }
    }
    
    
    return cell;
}



#pragma mark - UICollectionViewDelegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    // TODO: Select Item
//    NSLog(@"did touch cell");
//    NSLog(@"index: %i",indexPath.row);
//    NSLog(@"section: %i",indexPath.section);
//    
//    
//    
//}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
    
}

-(void)cellSwipe:(UISwipeGestureRecognizer *)gesture
{
    NSLog(@"cellSwipe");
    CGPoint location = [gesture locationInView:self.collectionView];
    NSIndexPath *swipedIndexPath = [self.collectionView indexPathForItemAtPoint:location];
    NSLog(@"index: %i",swipedIndexPath.row);
    NSLog(@"section: %i",swipedIndexPath.section);
    
    //DateCell *swipedCell  = [self.collectionView cellForItemAtIndexPath: swipedIndexPath];
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