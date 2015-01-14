//
//  LOTStudentListViewController.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 11/29/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//



//Areas of concern:
//I didn't "InsertNewObject..." when I created courseSavedToCoreData. It seems to save it to the LOTRecord entity, but maybe it saves it differently somewhere.


#import "LOTStudentListViewController.h"
#import "LOTStudent.h"
#import "LOTRecord.h"
#import "LOTCourse.h"

@interface LOTStudentListViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *studentTableView;
@property (weak, nonatomic) IBOutlet UITextField *assignmentTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
- (IBAction)doneButton:(id)sender;
- (IBAction)cancelButton:(id)sender;






@end


@implementation LOTStudentListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.studentTableView.delegate = self;
    self.studentTableView.dataSource = self;
    self.assignmentTextField.delegate = self;
    self.dateTextField.delegate = self;
    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchData];
    self.dateTextField.text = [NSString stringWithFormat:@"%@",[NSDate date]];
    [self createDuplicateCourseWithStudentsForRecord];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listOfStudents count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     
    static NSString * reuseIdentifier = @"studentCell";
     MGSwipeTableCell * cell = [self.studentTableView dequeueReusableCellWithIdentifier:reuseIdentifier];
     if (!cell) {
         cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
     }
     
     LOTStudent *currentStudent = self.listOfStudents[indexPath.row];
     cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",currentStudent.firstName, currentStudent.lastName];
     cell.detailTextLabel.text = @"Detail text";
     cell.delegate = self;
     cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"👍" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor greenColor]]];
     
     cell.leftExpansion.buttonIndex = 1;
     cell.leftExpansion.fillOnTrigger = YES;
     cell.leftSwipeSettings.transition = MGSwipeTransition3D;
     
    
     
     cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"👎" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor redColor]]];
     
     cell.rightExpansion.buttonIndex = 1;
     cell.rightExpansion.fillOnTrigger = YES;
     cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
     
    // NSLog(@"swipe state %ld",cell.swipeState);
     
     return cell;
 }


- (void) swipeTableCell:(MGSwipeTableCell *)cell didChangeSwipeState:(MGSwipeState)state gestureIsActive:(BOOL)gestureIsActive{
    
    
    if (cell.swipeState == 1) {
        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
        tempStudent.assignment = @"yes";
        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
   //     NSLog(@"cell number %@",[NSString stringWithFormat:@"%ld",swipedCell.row]);
    cell.backgroundColor = [UIColor greenColor];
    }
    else if (cell.swipeState == 2) {
        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
        tempStudent.assignment = @"no";
        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
    //    NSLog(@"cell number %@",[NSString stringWithFormat:@"%ld",swipedCell.row]);
        cell.backgroundColor = [UIColor redColor];
    }
    
    
}



 #pragma mark - Navigation
 
/*
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

 }
*/



- (IBAction)doneButton:(id)sender {

    [self findSpecificCourseInCoreData:@"LOTCourse" matchingString:@"id"];
    [self findSpecificRecordInCoreData:@"LOTRecord" matchingString:self.courseSavedToCoreData.courseName];
    [self.dataStore save];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)cancelButton:(id)sender {
    //retrieves LOTCourse created upon ViewDidLoad and erases it
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSString *dupCourseAssignment = @"id";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"assignment like %@",dupCourseAssignment];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchingData = [self.dataStore.managedObjectContext executeFetchRequest:request error:&error];
    for (LOTCourse *courseToDelete in matchingData) {
        [self.dataStore.managedObjectContext deleteObject:courseToDelete];
    }
    [self.navigationController popViewControllerAnimated:YES];
}



-(void) createDuplicateCourseWithStudentsForRecord{
    LOTCourse *dupCourse = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
    dupCourse.courseName = self.chosenCourse.courseName;
    dupCourse.assignment = @"id";

    for (LOTStudent *tempStudent in self.chosenCourse.students) {
        LOTStudent *duplicatedStudent = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.dataStore.managedObjectContext];
        duplicatedStudent.firstName = tempStudent.firstName;
        duplicatedStudent.lastName = tempStudent.lastName;
        [dupCourse addStudentsObject:duplicatedStudent];
    }
    
    [self.dataStore save];
    
    self.listOfStudents = [[NSMutableArray alloc] init];
    [self.listOfStudents addObjectsFromArray:[dupCourse.students allObjects]];
    
}


-(void)findSpecificCourseInCoreData:(NSString *)entity matchingString:(NSString *)matchingString{
    
    //This will find and fetch a specific object in core data
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:entity inManagedObjectContext:self.dataStore.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"assignment like %@",matchingString];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchingData = [self.dataStore.managedObjectContext executeFetchRequest:request error:&error];
    
    
    self.courseSavedToCoreData = matchingData[0];
    NSLog(@"stuff in matchingData %@",matchingData);
    self.courseSavedToCoreData.assignment = self.assignmentTextField.text;
    //Date won't reflect what people type in
    self.courseSavedToCoreData.date = [NSDate date];
    
    for (LOTStudent *temp in self.listOfStudents) {
        [self.courseSavedToCoreData addStudentsObject:temp];
    }
}

-(void)findSpecificRecordInCoreData:(NSString *)entity matchingString:(NSString *)matchingString{
    
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:entity inManagedObjectContext:self.dataStore.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseName like %@",self.courseSavedToCoreData.courseName];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchingData = [self.dataStore.managedObjectContext executeFetchRequest:request error:&error];
    
    LOTRecord *recordForThisClass = matchingData[0];
    
    recordForThisClass.courseName = self.courseSavedToCoreData.courseName;
    [recordForThisClass addCoursesObject:self.courseSavedToCoreData];
    
    
    
    
    
}

@end

