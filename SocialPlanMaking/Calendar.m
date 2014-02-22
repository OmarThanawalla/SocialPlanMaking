//
//  Calendar.m
//  SocialPlanMaking
//
//  Created by Omar Thanawalla on 1/28/14.
//  Copyright (c) 2014 Omar Thanawalla. All rights reserved.
//

#import "Calendar.h"
#import "DateCell.h"
#define days 5
#define hours 15

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
    
    [self prepareScheduleArray];

}

-(void)prepareScheduleArray
{
    
    
    self.schedule = [[NSMutableArray alloc] initWithCapacity:hours];
    
    //initialize 2D Array
    for (int i = 0; i < hours; i++)
    {
        NSMutableArray * temp = [[NSMutableArray alloc] initWithCapacity:days];
        for (int j = 0; j < days; j++) {
            NSNumber *number = [NSNumber numberWithInt:0];
            [temp insertObject:number atIndex:j];
        }
        
        [self.schedule insertObject:temp atIndex:i];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
// 1 -number of columns (left to right) (items is the elements in a a section like a column)
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {

    return days;
}

// 2 - number of rows (top to bottom) (sections is rows)
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return hours;
}

// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DateCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Time" forIndexPath:indexPath];
    
    cell.text.text = @"";
    
    //Color the cell
    // TODO: Deselect item
    NSNumber *value = self.schedule[indexPath.section][indexPath.row];
        //flip the value
    NSNumber * One = [NSNumber numberWithInt:1];
    if([value isEqualToNumber:One])
    {
        
        cell.backgroundColor = [UIColor greenColor];
    }else
    {
        cell.backgroundColor = [UIColor blueColor];
    }
    
    //Set up the text
    if(indexPath.row == 0)
    {
        switch (indexPath.section) {
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
            case 13:
                cell.text.text = @"1AM";
                break;

            case 14:
                cell.text.text = @"2AM";
                break;

                
                
            default:
                break;
        }
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            /*
            case 1:
                cell.text.text = @"M";
                break;
            case 2:
                cell.text.text = @"Tu";
                break;
            case 3:
                cell.text.text = @"W";
                break;
             */
            case 1:
                cell.text.text = @"Th";
                break;
            case 2:
                cell.text.text = @"F";
                break;
            case 3:
                cell.text.text = @"Sa";
                break;
            case 4:
                cell.text.text = @"Sun";
                break;
        
        
            default:
                break;
        }
    }
    
    
    return cell;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DateCell * cell = (DateCell *) [collectionView cellForItemAtIndexPath:indexPath];
    
    // TODO: Deselect item
    NSNumber *value = self.schedule[indexPath.section][indexPath.row];
    //flip the value
    NSNumber * One = [NSNumber numberWithInt:1];
    if([value isEqualToNumber:One])
    {
        value = [NSNumber numberWithInt:0];
        cell.backgroundColor = [UIColor blueColor];
    }else
    {
        value = [NSNumber numberWithInt:1];
        cell.backgroundColor = [UIColor greenColor];
    }
    self.schedule[indexPath.section][indexPath.row] = value;
    NSLog(@"Section: %i",indexPath.section);
    NSLog(@"Section: %i",indexPath.row);
    NSLog(@"Value: %@",value);
    
    

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

    CGSize retval = CGSizeMake(44, 44);
    
    return retval;
}

// 3 returns the spacing between the cells, headers, and footers.
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 20, 2, 2);
}


@end
