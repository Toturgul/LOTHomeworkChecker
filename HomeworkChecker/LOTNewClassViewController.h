//
//  LOTNewClassViewController.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/7/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOTDataStore.h"
@interface LOTNewClassViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
//array for LOTStudent objects to be used in this table view and LOTClassList table
@property (strong, nonatomic) NSMutableArray *namesArray;
//array for LOTStudent objects to be used in Records and LOTStudentList VC
@property (strong, nonatomic) NSMutableArray *namesForRecordArray;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) LOTDataStore *dataStore;

@end
