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

@property (strong, nonatomic) NSMutableArray *namesArray;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) LOTDataStore *dataStore;

@end
