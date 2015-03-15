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


@interface LOTStudentListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, UINavigationBarDelegate>

@property (strong, nonatomic) NSMutableArray * listOfStudents;
@property (strong, nonatomic) LOTCourse *chosenCourse;
@property (strong, nonatomic) LOTDataStore *dataStore;
@property (strong, nonatomic) LOTCourse *courseSavedToCoreData;




-(void)createDuplicateCourseWithStudentsForRecord;
-(LOTCourse *)segmentedControlCourse:(NSString *)currentOrLast;
-(void)saveResults;
-(NSString *)dateAsString;



@end

/* What happens here:
 createDuplicateCourse... will create new LOTcourse entity "dupCourse",copy the courseName and create new LOTStudent entities to make copies of the LOTstudents in "chosenCourse"
 Then it saves the newly created students to dupCourse.
 "chosenCourse" is not used beyond this point.
 Later the LOTStudents in dupcourse are modified to reflect information from this assignment.
 The LOTStudents in dupcourse are placed into a new LOTCourse "courseSavedToCoreData". Then saved. Both LOTCourses are the same course, just the name changes. At the end only one new course is created, regardless of the name.
 The appropriate LOTRecord is fetched and the course is added to it. Just like the LOTCourse, the LOTRecord has a new name  (instance name, not to be confused with .courseName). It doesn't matter that the name is changed, it is still the same LOTRecord that will be used over and over for this course.
 */
 


