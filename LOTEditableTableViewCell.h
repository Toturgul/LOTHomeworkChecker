//
//  LOTEditableTableViewCell.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/19/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOTEditableTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

@end
