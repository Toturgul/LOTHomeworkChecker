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

@interface LOTStudentListViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *studentTableView;
@property (weak, nonatomic) IBOutlet UITextField *assignmentTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
- (IBAction)doneButton:(id)sender;
- (IBAction)cancelButton:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentOutlet;
- (IBAction)segmentAction:(id)sender;
@property (strong, nonatomic) LOTCustomClass *customClass;




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
    [self createDuplicateCourseWithStudentsForRecord];
    self.customClass = [[LOTCustomClass alloc]init];
    self.dateTextField.text = [self.customClass todaysDateAsString];
    self.studentTableView.rowHeight = 78;

    NSSortDescriptor *numberOrder = [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES];
    [self.listOfStudents sortUsingDescriptors:@[numberOrder]];
    

    
    
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
     cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"YES" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor greenColor]],
                           [MGSwipeButton buttonWithTitle:@"Absent" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor blueColor]]];
                          
     
     cell.leftExpansion.buttonIndex = 1;
     cell.leftExpansion.fillOnTrigger = YES;
     cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
     
    
     
     cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"NO" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor redColor]]];
     
     cell.rightExpansion.buttonIndex = 1;
     cell.rightExpansion.fillOnTrigger = YES;
     cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
     
     return cell;
 }


- (void) swipeTableCell:(MGSwipeTableCell *)cell didChangeSwipeState:(MGSwipeState)state gestureIsActive:(BOOL)gestureIsActive{
    
    
    if (cell.swipeState == 1) {
        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
        tempStudent.hwCompletion = @"yes";
        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
    cell.backgroundColor = [UIColor greenColor];
    }
    else if (cell.swipeState == 2) {
        NSIndexPath *swipedCell = [self.studentTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.listOfStudents[swipedCell.row];
        tempStudent.hwCompletion = @"no";
        [self.listOfStudents replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
        cell.backgroundColor = [UIColor redColor];
    }
    
    
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion{
    NSLog(@"button tapped indexpath ");
    
    return NO;
}


 #pragma mark - Navigation
 
/*
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

 }
*/



- (IBAction)doneButton:(id)sender {

    
  //  LOTCustomClass *matchingData = [[LOTCustomClass alloc] init];
    self.courseSavedToCoreData = [[self.customClass findSpecificEntity:@"LOTCourse"
                                           byMatchingThisAttribute:@"assignment"
                                                      withThisTerm:@"id"] lastObject];
    
    self.courseSavedToCoreData.assignment = self.assignmentTextField.text;
    self.courseSavedToCoreData.date = [NSDate date];
    NSLog(@"date: %@",self.courseSavedToCoreData.date);
    
    for (LOTStudent *temp in self.listOfStudents) {
        temp.assignment = self.assignmentTextField.text;
        temp.date = [NSDate dateWithTimeIntervalSinceReferenceDate:162000];
        [self.courseSavedToCoreData addStudentsObject:temp];
    }
    
    LOTRecord *recordForThisClass = [[self.customClass findSpecificEntity:@"LOTRecord"
                                              byMatchingThisAttribute:@"courseName"
                                                         withThisTerm:self.courseSavedToCoreData.courseName] lastObject];
    
    recordForThisClass.courseName = self.courseSavedToCoreData.courseName;
    [recordForThisClass addCoursesObject:self.courseSavedToCoreData];

    [self.dataStore save];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)cancelButton:(id)sender {
    
    //retrieves LOTCourse created upon ViewDidLoad and erases it
  //  LOTCustomClass *matchingData = [[LOTCustomClass alloc] init];
    for (LOTCourse *courseToDelete in [self.customClass findSpecificEntity:@"LOTCourse"
                                               byMatchingThisAttribute:@"assignment"
                                                          withThisTerm:@"id"]) {
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
    
    [self.studentTableView reloadData];
    
}
@end

