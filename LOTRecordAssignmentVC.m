//
//  LOTRecordAssignmentVC.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/10/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTRecordAssignmentVC.h"
#import "LOTRecord.h"
#import "LOTCourse.h"
#import "LOTRecordStudentVC.h"
@interface LOTRecordAssignmentVC ()
@property (weak, nonatomic) IBOutlet UITableView *recordTableView;

@end

@implementation LOTRecordAssignmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    
    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchRecord];
    
    self.assignmentArray = [self.chosenRecord.courses allObjects];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.assignmentArray count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordAssignment" forIndexPath:indexPath];
 
     LOTCourse *cellFiller = self.assignmentArray[indexPath.row];
     cell.textLabel.text = cellFiller.assignment;
     cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",cellFiller.date];
     
     
 
 return cell;
 }
 






#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *chosenIndexPath = [self.recordTableView indexPathForSelectedRow];
    LOTCourse *chosenAssignment = self.assignmentArray[chosenIndexPath.row];
    LOTRecordStudentVC *studentsVC = segue.destinationViewController;
    studentsVC.chosenAssignment = chosenAssignment;
    [self.dataStore save];
    

}
@end
