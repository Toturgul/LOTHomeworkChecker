//
//  LOTRecordAssignmentVC.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/10/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOTDataStore.h"
#import "LOTCourse.h"
@interface LOTRecordAssignmentVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) LOTDataStore *dataStore;
@property (strong, nonatomic) LOTCourse *chosenCourse;
@property (strong, nonatomic) NSArray *recordArray;
@end
