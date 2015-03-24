//
//  LOTRecordStudentVC.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/10/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell.h>
#import <MGSwipeButton.h>

@class LOTCourse;
@interface LOTRecordStudentVC : UIViewController <UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate>

@property (strong, nonatomic) NSMutableArray *studentsArray;
@property (strong, nonatomic) LOTCourse *chosenAssignment;

@end
