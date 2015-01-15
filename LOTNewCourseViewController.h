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


@property (strong, nonatomic) NSMutableArray *namesForListArray;


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) LOTDataStore *dataStore;


-(void)createAndSaveStudent;
-(void)completeNewCourse;

@end
