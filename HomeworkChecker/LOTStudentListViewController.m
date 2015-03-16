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
#import "LOTCustomClass.h"
#import "LOTDatePickerVC.h" //might not need to import this anymore

@interface LOTStudentListViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *studentTableView;
@property (weak, nonatomic) IBOutlet UITextField *assignmentTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
- (IBAction)doneButton:(id)sender;
- (IBAction)cancelButton:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentOutlet;
- (IBAction)segmentAction:(id)sender;
@property (strong, nonatomic) LOTCustomClass *customClass;
@property (nonatomic) NSInteger segmentedControlTouched;
- (IBAction)dateAction:(id)sender;

@property (weak, nonatomic) LOTDatePickerVC* editDate;

@end




@implementation LOTStudentListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.studentTableView.delegate = self;
    self.studentTableView.dataSource = self;
    self.assignmentTextField.delegate = self;
    self.dateTextField.delegate = self;
    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchRecord];
    [self createDuplicateCourseWithStudentsForRecord];
    self.customClass = [[LOTCustomClass alloc]init];
    self.dateTextField.text = [self.customClass todaysDateAsString];
    self.studentTableView.rowHeight = 78;
    self.segmentedControlTouched = 1;

    
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    self.courseSavedToCoreData = [[self.customClass findSpecificEntity:@"LOTCourse"
                                               byMatchingThisAttribute:@"assignment"
                                                          withThisTerm:@"id"] lastObject];
    
    if (!(self.courseSavedToCoreData.date == nil)) {
        self.dateTextField.text = [self dateAsString];
    }
    

    
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
     NSSortDescriptor *numberOrder = [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES];
     [self.listOfStudents sortUsingDescriptors:@[numberOrder]];
     
    static NSString * reuseIdentifier = @"studentCell";
     MGSwipeTableCell * cell = [self.studentTableView dequeueReusableCellWithIdentifier:reuseIdentifier];
     if (!cell) {
         cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
     }
     
     cell.backgroundColor = [UIColor clearColor];
     LOTStudent *currentStudent = self.listOfStudents[indexPath.row];
     cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",currentStudent.firstName, currentStudent.lastName];
     
     if ([currentStudent.hwCompletion isEqual: @"No"]) {
         cell.backgroundColor = [UIColor redColor];
         cell.detailTextLabel.text = currentStudent.hwCompletion;
     }
     if ([currentStudent.hwCompletion isEqual:@"Yes"]) {
         cell.backgroundColor = [UIColor greenColor];
         cell.detailTextLabel.text = currentStudent.hwCompletion;
     }
     if ([currentStudent.hwCompletion isEqual: @"Absent"]) {
         cell.backgroundColor = [UIColor blueColor];
         cell.detailTextLabel.text = currentStudent.hwCompletion;
     }
     if ([currentStudent.hwCompletion isEqual:@"PC"]) {
         cell.backgroundColor = [UIColor purpleColor];
         cell.detailTextLabel.text = currentStudent.hwCompletion;
     }
     
     NSLog(@"reloaded");

     cell.delegate = self;
     cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"Yes" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor greenColor]]];
                          
     
     cell.leftExpansion.buttonIndex = 1;
     cell.leftExpansion.fillOnTrigger = YES;
     cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
     cell.leftExpansion.threshold = 1;
     
    
     
     cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"No" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor redColor]],
                           [MGSwipeButton buttonWithTitle:@"Absent" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor blueColor]],
                           [MGSwipeButton buttonWithTitle:@"PC" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor purpleColor]]];
     
     cell.rightExpansion.buttonIndex = 1;
     cell.rightExpansion.fillOnTrigger = YES;
     cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
     cell.leftExpansion.threshold = 1;
     return cell;
 }


- (void) swipeTableCell:(MGSwipeTableCell *)cell didChangeSwipeState:(MGSwipeState)state gestureIsActive:(BOOL)gestureIsActive{
    
    
    if (cell.swipeState == 1) {
        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
        tempStudent.hwCompletion = @"Yes";
        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
    cell.backgroundColor = [UIColor greenColor];
    }
//    else if (cell.swipeState == 2) {
//        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
//        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
//        tempStudent.hwCompletion = @"no";
//        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
//        cell.backgroundColor = [UIColor redColor];
//    }
    
    
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion{
    NSLog(@"button tapped indexpath ");

    if (direction == 0 && index == 0){
        NSLog(@"tapped 1");
        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
        tempStudent.hwCompletion = @"Yes";
        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
        cell.backgroundColor = [UIColor greenColor];
    }
    if (direction == 1 && index == 0){
        NSLog(@"tapped 0");
        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
        tempStudent.hwCompletion = @"No";
        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
        cell.backgroundColor = [UIColor redColor];
    }
    if (direction == 1 && index == 1){
        NSLog(@"tapped 1");
        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
        tempStudent.hwCompletion = @"Absent";
        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
        cell.backgroundColor = [UIColor blueColor];
    }
    if (direction == 1 && index == 2){
        NSLog(@"tapped 2");
        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
        tempStudent.hwCompletion = @"PC";
        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
        cell.backgroundColor = [UIColor purpleColor];
    }

    return YES;
}


 #pragma mark - Navigation
 
//
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     
//     
// }




- (IBAction)doneButton:(id)sender {

    if (self.segmentedControlTouched == 1) {
        [self saveResults];
    }   else {
        [self.dataStore save];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)cancelButton:(id)sender {
    
    //retrieves LOTCourse created upon ViewDidLoad and erases it
  //  LOTCustomClass *matchingData = [[LOTCustomClass alloc] init];
    for (LOTCourse *courseToDelete in [self.customClass findSpecificEntity:@"LOTCourse"
                                               byMatchingThisAttribute:@"assignment"
                                                          withThisTerm:@"id"]) {
        NSLog(@"cancel button: New Date %@", courseToDelete.date);
        [self.dataStore.managedObjectContext deleteObject:courseToDelete];
    }
    [self.navigationController popViewControllerAnimated:YES];

}



-(void) createDuplicateCourseWithStudentsForRecord{
    LOTCourse *dupCourse = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse"
                                                         inManagedObjectContext:self.dataStore.managedObjectContext];
    dupCourse.courseName = self.chosenCourse.courseName;
    dupCourse.assignment = @"id";
    NSLog(@"dupcourse name: %@",dupCourse.courseName);

    for (LOTStudent *tempStudent in self.chosenCourse.students) {
        LOTStudent *duplicatedStudent = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent"
                                                                      inManagedObjectContext:self.dataStore.managedObjectContext];
        duplicatedStudent.firstName = tempStudent.firstName;
        duplicatedStudent.lastName = tempStudent.lastName;
        duplicatedStudent.courseName = tempStudent.courseName;
        duplicatedStudent.order = tempStudent.order;
       // NSLog(@"student: %@",duplicatedStudent);
        [dupCourse addStudentsObject:duplicatedStudent];
    }
    
    self.listOfStudents = [[NSMutableArray alloc] init];
    [self.listOfStudents addObjectsFromArray:[dupCourse.students allObjects]];


}


- (IBAction)segmentAction:(id)sender {
    
    if (self.segmentedControlTouched == 1) {
        [self saveResults];
    } else {
        [self.dataStore save];
    }
    
    self.segmentedControlTouched++;
    if (self.segmentOutlet.selectedSegmentIndex == 0) {
        NSLog(@"assignment name: %@",[self segmentedControlCourse:@"last"]);
        LOTCourse *tempCourse = [self segmentedControlCourse:@"last"];
        self.assignmentTextField.text = tempCourse.assignment;
        self.listOfStudents = [[NSMutableArray alloc]initWithArray:[tempCourse.students allObjects]];
        [self.studentTableView reloadData];
        
        
    }
    if (self.segmentOutlet.selectedSegmentIndex == 1) {
        NSLog(@"assignment name: %@",[self segmentedControlCourse:@"current"]);
        LOTCourse *tempCourse = [self segmentedControlCourse:@"current"];
        self.listOfStudents = [[NSMutableArray alloc]initWithArray:[tempCourse.students allObjects]];
        [self.studentTableView reloadData];

    }
    
    //[self.customClass segmentControlTouched];

}

-(LOTCourse *)segmentedControlCourse:(NSString *)currentOrLast{
    
    NSMutableArray *arrayOfCourses = [[NSMutableArray alloc]initWithArray:
                                      [self.customClass findSpecificEntity:@"LOTCourse"
                                                   byMatchingThisAttribute:@"courseName"
                                                              withThisTerm:[NSString stringWithFormat:@"%@",self.chosenCourse.courseName]]];
    
    
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    [arrayOfCourses sortUsingDescriptors:@[dateDescriptor]];
    if ([currentOrLast isEqualToString:@"last"]) {
        LOTCourse *hwCourse = [arrayOfCourses objectAtIndex:[arrayOfCourses count]-2];
        return hwCourse;
    }
    if ([currentOrLast isEqualToString:@"current"]) {
        LOTCourse *hwCourse = [arrayOfCourses lastObject];
        return hwCourse;
    }
    NSLog(@"Neither last or current assinment were retrieved");
    return nil;
}


-(void)saveResults{
    
    self.courseSavedToCoreData = [[self.customClass findSpecificEntity:@"LOTCourse"
                                               byMatchingThisAttribute:@"assignment"
                                                          withThisTerm:@"id"] lastObject];
    
    self.courseSavedToCoreData.assignment = self.assignmentTextField.text;
    if (self.courseSavedToCoreData.date == nil) {
        self.courseSavedToCoreData.date = [NSDate date];
    }

    NSLog(@"date: %@",self.courseSavedToCoreData.date);
    
    for (LOTStudent *temp in self.listOfStudents) {
        temp.assignment = self.assignmentTextField.text;
        temp.date = self.courseSavedToCoreData.date;
        NSLog(@"student date %@",temp);
        [self.courseSavedToCoreData addStudentsObject:temp];
    }
    
    LOTRecord *recordForThisClass = [[self.customClass findSpecificEntity:@"LOTRecord"
                                                  byMatchingThisAttribute:@"courseName"
                                                             withThisTerm:self.courseSavedToCoreData.courseName] lastObject];
    
    recordForThisClass.courseName = self.courseSavedToCoreData.courseName;
    [recordForThisClass addCoursesObject:self.courseSavedToCoreData];
    
    [self.dataStore save];
}




- (IBAction)dateAction:(id)sender {
    
    LOTDatePickerVC *datePicker = [self.storyboard instantiateViewControllerWithIdentifier:@"datePicker"];
    [self presentViewController:datePicker animated:YES completion:^{}];
}


-(NSString*)dateAsString{
    

    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    NSString *date = [format stringFromDate:self.courseSavedToCoreData.date];
    return date;
    
}

@end
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if (textField == self.dateTextField) {
////        UIViewController *datePicker = [self.storyboard instantiateViewControllerWithIdentifier:@"datePicker"];
////        [self presentViewController:datePicker animated:YES completion:^{}];
//        return NO;
//    }
//    return YES;
//}

//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    UIViewController *datePicker = [self.storyboard instantiateViewControllerWithIdentifier:@"datePicker"];
//    [self presentViewController:datePicker animated:YES completion:^{}];
//    
//    
//}

//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    UIViewController *datePicker = [self.storyboard instantiateViewControllerWithIdentifier:@"datePicker"];
//    [self presentViewController:datePicker animated:YES completion:^{}];
//}



