//
//  LOTNewClassViewController.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/7/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTNewClassViewController.h"
#import "LOTCourse.h"
#import "LOTStudent.h"
#import "LOTRecord.h"
@interface LOTNewClassViewController ()<UITextFieldDelegate>
@property (nonatomic) NSInteger editNumber;
@property (weak, nonatomic) IBOutlet UITableView *addStudentsTableView;
- (IBAction)addStudentButton:(id)sender;
- (IBAction)editButton:(id)sender;
- (IBAction)doneButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *numOfStudentsLabel;

@property (weak, nonatomic) IBOutlet UITextField *courseLabel;


@end

@implementation LOTNewClassViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.addStudentsTableView.delegate = self;
    self.addStudentsTableView.dataSource = self;
    self.courseLabel.delegate = self;
    
    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchData];
    
    self.editNumber = 2;
    
    
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    self.addStudentsTableView.backgroundColor = [UIColor yellowColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    LOTStudent *newStudent = self.namesArray[indexPath.row];
    cell.textLabel.text = newStudent.name;
    cell.backgroundColor = [UIColor yellowColor];

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
    //inits self.namesArray if it is empty
    if (!self.namesArray) {
        self.namesArray = [[NSMutableArray alloc]init];
        self.namesForRecordArray = [[NSMutableArray alloc] init];
    }
    
    // Make sure the button they clicked wasn't Cancel
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        
        //create student for array used in this table view and LOTClassList table view
        LOTStudent *newStudentForList = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.dataStore.managedObjectContext];
        newStudentForList.name = textField.text;
        [self.namesArray insertObject:newStudentForList atIndex:0];
        
        //create student for array to be used in Records and LOTStudentList
        LOTStudent *newStudentForRecord = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.dataStore.managedObjectContext];
        newStudentForRecord.name = textField.text;
        [self.namesForRecordArray insertObject:newStudentForRecord atIndex:0];
        
        
        [self.addStudentsTableView reloadData];
        
        self.numOfStudentsLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[self.namesArray count]];
        
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 //   NSLog(@"You clicked %li",buttonIndex);
    
}



- (IBAction)addStudentButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Student" message:@"Enter Student Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [alert show];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;


    
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
        [self.namesForRecordArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (IBAction)editButton:(id)sender {
    
    
 //turns on and off edit every other time the button is touched
    if (self.editNumber%2==0) {
    self.editing = YES;
        self.editNumber++;
    }
    else {
        self.editing = NO;
        self.editNumber++;
    }
    
}

- (IBAction)doneButton:(id)sender {
    
    if ([self.courseLabel.text length] == 0) {
        NSLog(@"No class created");
        [self dismissViewControllerAnimated:YES completion:^{
            }];
    }
    else {
    
    //create a new LOTCourse and adds students only to be used to display courses on LOTClassList
    LOTCourse *courseForClassList = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
        courseForClassList.courseName = self.courseLabel.text;
        courseForClassList.assignment = @"justForClassList";

        for (LOTStudent *temp in self.namesArray) {
            [courseForClassList addStudentsObject:temp];
//            NSLog(@"courseForClassList: %lu",(unsigned long)[courseForClassList.students count]);
        }
    
    //create a new LOTRecord and LOTCourse and adds students to be used in Records and LOTStudentListVC

    LOTRecord *newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"LOTRecord" inManagedObjectContext:self.dataStore.managedObjectContext];
        newRecord.courseName = self.courseLabel.text;
        
    LOTCourse *courseForRecords = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
        courseForRecords.courseName = self.courseLabel.text;
    
        for (LOTStudent *temp in self.namesForRecordArray) {
            [courseForRecords addStudentsObject:temp];
//            NSLog(@"courseForRecord: %lu %lu",(unsigned long)[courseForRecords.students count],(unsigned long)[courseForClassList.students count]);
        }
        
        [newRecord addCoursesObject:courseForRecords]; //may need to erase this
        
    [self.dataStore save];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

@end
