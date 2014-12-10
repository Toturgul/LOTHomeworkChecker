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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;




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
    
    
    self.listOfStudents = [self.chosenCourse.students allObjects];
    
    
    
    NSLog(@"hi sir");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
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
     
     NSLog(@"swipe state %ld",cell.swipeState);
     return cell;
 }

- (void) swipeTableCell:(MGSwipeTableCell *)cell didChangeSwipeState:(MGSwipeState)state gestureIsActive:(BOOL)gestureIsActive{
    
    
    if (cell.swipeState == 2) {
    
    cell.backgroundColor = [UIColor redColor];
    }
    else if (cell.swipeState == 1) {
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

