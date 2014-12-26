//
//  LOTRecordCourseVC.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/10/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTRecordCourseVC.h"
#import "LOTCourse.h"
#import "LOTRecordAssignmentVC.h"
@interface LOTRecordCourseVC ()
@property (weak, nonatomic) IBOutlet UITableView *recordTableView;

@end

@implementation LOTRecordCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    
    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataStore.courseArray count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 
     static NSString *cellIdentifier = @"recordCourse";
     UITableViewCell *cell = [self.recordTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
     
     LOTCourse *cellFiller = self.dataStore.courseArray[indexPath.row];
     cell.textLabel.text = cellFiller.courseName;
 
 return cell;
 }
 







#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *chosenIndexPath = [self.recordTableView indexPathForSelectedRow];
    LOTCourse *chosenCourse = self.dataStore.courseArray[chosenIndexPath.row];
    LOTRecordAssignmentVC *recordVC = segue.destinationViewController;
    recordVC.chosenCourse = chosenCourse;
    
}


@end
