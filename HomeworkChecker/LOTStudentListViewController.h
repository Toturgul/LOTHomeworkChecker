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
#import "LOTDataStore.h"
@class LOTCourse;


@interface LOTStudentListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, UIActionSheetDelegate, UINavigationBarDelegate>

@property (strong, nonatomic) NSMutableArray * listOfStudents;
@property (strong, nonatomic) LOTCourse *chosenCourse;
@property (strong, nonatomic) LOTDataStore *dataStore;
@property (strong, nonatomic) LOTCourse *courseSavedToCoreData;



//Whatever attibute I give a student in LOTNewCourse, I need to give it in this method
-(void)createDuplicateCourseWithStudentsForRecord;

-(void)findSpecificCourseInCoreData:(NSString*)entity matchingString:(NSString*)matchingString;
-(void)findSpecificRecordInCoreData:(NSString*)entity matchingString:(NSString*)matchingString;



@end
