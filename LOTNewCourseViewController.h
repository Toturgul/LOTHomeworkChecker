//
//  LOTNewCourseViewController.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/6/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOTNewCourseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>


@property (strong, nonatomic) NSMutableArray *namesForListArray;
@property (strong, nonatomic) NSString *name;



-(void)createAndSaveStudent;
-(void)completeNewCourse;

@end
