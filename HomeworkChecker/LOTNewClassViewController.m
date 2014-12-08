//
//  LOTNewClassViewController.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/7/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTNewClassViewController.h"

@interface LOTNewClassViewController ()
@property (weak, nonatomic) IBOutlet UITableView *addStudentsTableView;
- (IBAction)addStudentButton:(id)sender;
- (IBAction)editButton:(id)sender;


@end

@implementation LOTNewClassViewController
//@synthesize addStudentsTableView, namesArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addStudentsTableView.delegate = self;
    self.addStudentsTableView.dataSource = self;
    self.namesArray = [[NSMutableArray alloc] initWithObjects:@"Elisa",@"Levan",@"Summer", nil];
    
    NSLog(@"%@",self.namesArray);
    [self.addStudentsTableView reloadData];
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
    
    static NSString *cellIdentifier = @"nameCell";
UITableViewCell *cell = [self.addStudentsTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.namesArray[indexPath.row];

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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Make sure the button they clicked wasn't Cancel
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        self.name = textField.text;
        NSLog(@"%@", textField.text);
        [self.addStudentsTableView reloadData];
        NSLog(@"%@",self.namesArray);
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"You clicked %li",buttonIndex);
    
}



- (IBAction)addStudentButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Student" message:@"Enter Student Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [alert show];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    UITextField *textField = [alert textFieldAtIndex:0];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@",textField.text]);
//    NSString *tempName = [NSString stringWithFormat:@"%@",textField.text];
//    [self.namesArray addObject:tempName];
    
}




//Puts view controller in edit mode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.addStudentsTableView setEditing:editing animated:animated ];
}


//Next two methods allow for editing of cells in the table
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.namesArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (IBAction)editButton:(id)sender {
    
    
}

@end
