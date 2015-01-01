//
//  LOTRecordCourseVC.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/10/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOTDataStore.h"
@interface LOTRecordCourseVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) LOTDataStore *dataStore;

@end


