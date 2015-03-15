//
//  LOTDatePickerVC.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 2/5/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOTDataStore.h"
#import "LOTCustomClass.h"
#import "LOTCourse.h"


@interface LOTDatePickerVC : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) LOTDataStore *dataStore;



@end
