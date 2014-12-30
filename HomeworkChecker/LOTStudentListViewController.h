//
//  LOTStudentListViewController.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 11/29/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell.h>
#import <MGSwipeButton.h>
#import "LOTCourse.h"
#import "LOTDataStore.h"
#import "LOTRecord.h"

@interface LOTStudentListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableArray * listOfStudents;
@property (strong, nonatomic) LOTCourse *chosenCourse;
@property (strong, nonatomic) LOTDataStore *dataStore;


-(void)createTempCourseForRecord;
-(void)createDuplicateCourseWithStudentsForRecord;


@end
