//
//  LOTDatePickerVC.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 2/5/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface LOTDatePickerVC : UIViewController <UITextFieldDelegate>

-(void)changeDate:(void (^)(id newDate))dateBlock;

@end
