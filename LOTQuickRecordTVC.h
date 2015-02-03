//
//  LOTQuickRecordTVC.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/28/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell.h>
#import <MGSwipeButton.h>
#import "LOTDataStore.h"
@class LOTCourse;
@interface LOTQuickRecordTVC : UITableViewController <MGSwipeTableCellDelegate>
//@property (strong, nonatomic) LOTDataStore *dataStore;
//@property (strong, nonatomic) NSMutableArray *studentsArray;
//@property (strong, nonatomic) LOTCourse *chosenAssignment;

@property (strong, nonatomic) NSMutableArray *nameArray;


@end
