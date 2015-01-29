//
//  LOTRecordStudentVC.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/10/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTRecordStudentVC.h"
#import "LOTCourse.h"
#import "LOTStudent.h"
@interface LOTRecordStudentVC ()
@property (weak, nonatomic) IBOutlet UITableView *recordTableView;

@end

@implementation LOTRecordStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchRecord];
    self.studentsArray = [[NSMutableArray alloc]initWithArray:[self.chosenAssignment.students allObjects]];
    NSLog(@"self.studentsArray : %@", self.studentsArray);
    NSLog(@"self.chosenAssignment.students : %@", self.chosenAssignment.students);

    UIBarButtonItem *myButton = [[UIBarButtonItem alloc]init];
    myButton.action = @selector(doTheThing);
    myButton.title = @"👈Back";
    myButton.target = self;
    self.navigationItem.leftBarButtonItem = myButton;


    
    
    
}

- (void) doTheThing {
    [self.dataStore save];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Doing the thing");
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.studentsArray count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 //MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordStudent" forIndexPath:indexPath];
 
     //Load with HW Results from memory
     static NSString * reuseIdentifier = @"recordCell";
     MGSwipeTableCell * cell = [self.recordTableView dequeueReusableCellWithIdentifier:reuseIdentifier];
     if (!cell) {
         cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
     }
     
     LOTStudent *cellFiller = self.studentsArray[indexPath.row];
     cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",cellFiller.firstName, cellFiller.lastName];
     
     if ([cellFiller.hwCompletion isEqual: @"no"]) {
         cell.backgroundColor = [UIColor redColor];
         cell.detailTextLabel.text = cellFiller.hwCompletion;
     }
     if ([cellFiller.hwCompletion isEqual:@"yes"]) {
         cell.backgroundColor = [UIColor greenColor];
         cell.detailTextLabel.text = cellFiller.hwCompletion;
     }
     
     
     //set up properties of each cell, it will come into play if the user swipes a cell.
     cell.detailTextLabel.text = @"Detail text";
     cell.delegate = self;
     cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"YES" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor greenColor]]];
     
     cell.leftExpansion.buttonIndex = 1;
     cell.leftExpansion.fillOnTrigger = YES;
     cell.leftSwipeSettings.transition = MGSwipeTransition3D;
     
     
     
     cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"NO" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor redColor]]];
     
     cell.rightExpansion.buttonIndex = 1;
     cell.rightExpansion.fillOnTrigger = YES;
     cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
 
 return cell;
 }
 

- (void) swipeTableCell:(MGSwipeTableCell *)cell didChangeSwipeState:(MGSwipeState)state gestureIsActive:(BOOL)gestureIsActive{
    
    
    if (cell.swipeState == 1) {
        NSIndexPath *swipedCell = [self.recordTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.studentsArray[swipedCell.row];
        tempStudent.hwCompletion = @"yes";
        [self.studentsArray replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
        cell.backgroundColor = [UIColor greenColor];
    }
    else if (cell.swipeState == 2) {
        NSIndexPath *swipedCell = [self.recordTableView indexPathForCell:cell];
        LOTStudent *tempStudent = self.studentsArray[swipedCell.row];
        tempStudent.hwCompletion = @"no";
        [self.studentsArray replaceObjectAtIndex:swipedCell.row withObject:tempStudent];
        cell.backgroundColor = [UIColor redColor];
    }
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
