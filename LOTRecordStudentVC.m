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
    self.studentsArray = [self.chosenAssignment.students allObjects];
    
    
    
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
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordStudent" forIndexPath:indexPath];
 
     LOTStudent *cellFiller = self.studentsArray[indexPath.row];
     cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",cellFiller.firstName, cellFiller.lastName];
     
     if ([cellFiller.assignment isEqual: @"no"]) {
         cell.backgroundColor = [UIColor redColor];
         cell.detailTextLabel.text = cellFiller.assignment;
     }
     if ([cellFiller.assignment isEqual:@"yes"]) {
         cell.backgroundColor = [UIColor greenColor];
         cell.detailTextLabel.text = cellFiller.assignment;
     }
 
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

@end
