//
//  LOTStudentListViewController.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 11/29/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

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
    

//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
//     Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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









/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 #pragma mark - Navigation
 
/*
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

 }
*/

- (IBAction)doneButton:(id)sender {
  //  NSLog(@"done button, beginning: students in array: %li",[self.chosenCourse.students count]);
    
    
    //This will find and fetch a specific object in core data
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSString *dupCourseAssignment = @"id";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"assignment like %@",dupCourseAssignment];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchingData = [self.dataStore.managedObjectContext executeFetchRequest:request error:&error];
    
    
    
    LOTCourse *newCourse = matchingData[0];
    NSLog(@"stuff in matchingData %@",matchingData);
    newCourse.assignment = self.assignmentTextField.text;
    //Date won't reflect what people type in
    newCourse.date = [NSDate date];
    NSLog(@"newcourse %@ and matchingdata count %lu",newCourse.courseName, [matchingData count]);
    
    for (LOTStudent *temp in self.listOfStudents) {
        //   NSLog(@"name %@  did hw %@",temp.name, temp.assignment);
        NSLog(@"done button, inloop: students in array: %li",[self.chosenCourse.students count]);
        [newCourse addStudentsObject:temp];
    }
    
   //Calls up LOTrecord that goes with this course. ***TURN THIS INTO A METHOD, get rid of the "2"s
    NSEntityDescription *entitydesc2 = [NSEntityDescription entityForName:@"LOTRecord" inManagedObjectContext:self.dataStore.managedObjectContext];
    NSFetchRequest *request2 = [[NSFetchRequest alloc] init];
    [request2 setEntity:entitydesc2];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"courseName like %@",newCourse.courseName];
    [request2 setPredicate:predicate2];
    NSError *error2;
    NSArray *matchingData2 = [self.dataStore.managedObjectContext executeFetchRequest:request2 error:&error2];
    
    LOTRecord *recordForThisClass = matchingData2[0];
    NSLog(@"coursename: %@ ... recordCoursename %@",newCourse.courseName, recordForThisClass.courseName);
    recordForThisClass.courseName = newCourse.courseName;
    [recordForThisClass addCoursesObject:newCourse];
    //NSLog(@"recordForThisClass coursename: %@ and rest of stuff %@", recordForThisClass.courseName, recordForThisClass.courses);
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



//-(void)fetchAssignment{
//    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entitydesc];
//    NSString *dupCourseAssignment = @"id";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"assignment like %@",dupCourseAssignment];
//    [request setPredicate:predicate];
//    NSError *error;
//    NSArray *matchingData = [self.dataStore.managedObjectContext executeFetchRequest:request error:&error];
//    
//}


-(void) createDuplicateCourseWithStudentsForRecord{
    LOTCourse *dupCourse = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
    dupCourse.courseName = self.chosenCourse.courseName;
    dupCourse.assignment = @"id";
    NSLog(@"createDup method... courseName: %@",dupCourse.courseName);
    NSLog(@"chosenCourse assignment: %@", self.chosenCourse.assignment);
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


@end

