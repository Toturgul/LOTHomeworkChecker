//
//  DemoViewController.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 11/24/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell.h>
@interface DemoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, UIActionSheetDelegate>

@property (nonatomic, assign) BOOL testingStoryboardCell;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
