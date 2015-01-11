//
//  LOTNewCourseViewController.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/6/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOTDataStore.h"
@interface LOTNewCourseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

//array for LOTStudent objects to be used in this table view and LOTClassList table
@property (strong, nonatomic) NSMutableArray *namesForListArray;
//array for LOTStudent objects to be used in Records and LOTStudentList VC
@property (strong, nonatomic) NSMutableArray *namesForRecordArray;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) LOTDataStore *dataStore;


-(void)createAndSaveStudent;
-(void)completeNewCourse;

@end
