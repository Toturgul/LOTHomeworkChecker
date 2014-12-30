//
//  LOTStudentListViewController.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 11/29/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTStudentListViewController.h"
#import "LOTStudent.h"

@interface LOTStudentListViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *studentTableView;
@property (weak, nonatomic) IBOutlet UITextField *assignmentTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
- (IBAction)doneButton:(id)sender;






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
    
    self.listOfStudents = [[NSMutableArray alloc] init];
    [self.listOfStudents addObjectsFromArray:[self.chosenCourse.students allObjects]];
    
    NSLog(@"viewdidload, students in array: %li",[self.chosenCourse.students count]);
    

    
    
    
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

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.listOfStudents count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     
    static NSString * reuseIdentifier = @"studentCell";
     MGSwipeTableCell * cell = [self.studentTableView dequeueReusableCellWithIdentifier:reuseIdentifier];
     if (!cell) {
         cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
     }
     
     LOTStudent *currentStudent = self.listOfStudents[indexPath.row];
     cell.textLabel.text = currentStudent.name;
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
    
    
    if (cell.swipeState == 2) {
        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
        tempStudent.assignment = @"yes";
        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
   //     NSLog(@"cell number %@",[NSString stringWithFormat:@"%ld",swipedCell.row]);
    cell.backgroundColor = [UIColor redColor];
    }
    else if (cell.swipeState == 1) {
        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
        tempStudent.assignment = @"no";
        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
    //    NSLog(@"cell number %@",[NSString stringWithFormat:@"%ld",swipedCell.row]);
        cell.backgroundColor = [UIColor greenColor];
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
    
    
    LOTRecord *thisAssignmentInfo = [NSEntityDescription insertNewObjectForEntityForName:@"LOTRecord" inManagedObjectContext:self.dataStore.managedObjectContext];
    
    
    LOTCourse *newCourse = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
    newCourse.courseName = self.chosenCourse.courseName;
    newCourse.assignment = self.assignmentTextField.text;
 
    //Date won't reflect what people type in
    newCourse.date = [NSDate date];
    
    
    for (LOTStudent *temp in self.listOfStudents) {
        //   NSLog(@"name %@  did hw %@",temp.name, temp.assignment);
        NSLog(@"done button, inloop: students in array: %li",[self.chosenCourse.students count]);
        [newCourse addStudentsObject:temp];
    }
    

    
    [thisAssignmentInfo addCoursesObject:newCourse];
    
    
    
    [self.dataStore.managedObjectContext deleteObject:newCourse];
    
    [self.dataStore save];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    // //This will find and fetch a specific object in core data
    //    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
    //    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //    [request setEntity:entitydesc];
    //    NSString *temp = @"temp";
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"assignment like %@",temp];
    //    [request setPredicate:predicate];
    //    NSError *error;
    //    NSArray *matchingData = [self.dataStore.managedObjectContext executeFetchRequest:request error:&error];

    
    
    

    
//    LOTCourse *newCourse = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
//    newCourse.courseName = self.chosenCourse.courseName;
//    newCourse.assignment = self.assignmentTextField.text;
//    NSLog(@"assignment is: %@",newCourse.assignment);
//    //Date won't reflect what people type in
//    newCourse.date = [NSDate date];
//    
//    for (LOTStudent *temp in self.listOfStudents) {
//     //   NSLog(@"name %@  did hw %@",temp.name, temp.assignment);
//        [newCourse addStudentsObject:temp];
//    }
//    NSLog(@"newcourse: %@",newCourse.courseName);
    
    
//    [self.dataStore save];
//    [self.navigationController popViewControllerAnimated:YES];
}


-(void) createTempCourseForRecord{
    LOTCourse *tempCourse = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
    tempCourse.assignment = @"temp";
    [self.dataStore save];
    
}

@end

