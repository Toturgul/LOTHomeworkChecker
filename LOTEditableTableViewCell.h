//
//  LOTEditableTableViewCell.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/19/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOTCustomTextField.h"

@interface LOTEditableTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet LOTCustomTextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet LOTCustomTextField *lastNameTextField;


@end
