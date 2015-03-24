//
//  LOTRecordAssignmentVC.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/10/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LOTRecord;

@interface LOTRecordAssignmentVC : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) NSMutableArray *assignmentArray;
@property (strong, nonatomic) LOTRecord *chosenRecord;
-(NSString*)dateAsString;

@end
