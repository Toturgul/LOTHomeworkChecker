//
//  LOTNewCourseViewController.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/6/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import "LOTNewCourseViewController.h"

@interface LOTNewCourseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *studentListTableView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;






@end

@implementation LOTNewCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.studentListTableView.delegate = self;
    self.studentListTableView.dataSource = self;
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.namesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"studentCell";
    UITableViewCell *cell = [self.studentListTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];


    
    return cell;
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.firstNameTextField) {
        [self.lastNameTextField becomeFirstResponder];
    }
    if (textField == self.lastNameTextField) {
        [self.firstNameTextField becomeFirstResponder];
    }

    
    
    return YES;
}







@end
