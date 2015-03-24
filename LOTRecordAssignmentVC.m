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
#import "LOTDataStore.h"
@interface LOTRecordAssignmentVC ()
@property (weak, nonatomic) IBOutlet UITableView* recordTableView;
@property (weak, nonatomic) LOTCourse* cellFiller;
@property (strong, nonatomic) LOTDataStore *dataStore;
@end

@implementation LOTRecordAssignmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    
    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchRecord];
    
    self.assignmentArray = [[NSMutableArray alloc] initWithArray:[self.chosenRecord.courses allObjects]];
    
    NSSortDescriptor *dateSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [self.assignmentArray sortUsingDescriptors:@[dateSortDescriptor]];
    
    
    
//    NSLayoutConstraint *tableviewHeight =
//    [NSLayoutConstraint constraintWithItem:self.recordTableView
//                                 attribute:NSLayoutAttributeHeight
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.view
//                                 attribute:NSLayoutAttributeHeight
//                                multiplier:1.0
//                                  constant:0];
//    
//    [self.view addConstraint:tableviewHeight];
//    
//    NSLayoutConstraint *tableviewWidth =
//    [NSLayoutConstraint constraintWithItem:self.recordTableView
//                                 attribute:NSLayoutAttributeWidth
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.view
//                                 attribute:NSLayoutAttributeWidth
//                                multiplier:1.0
//                                  constant:0];
//    
//    [self.view addConstraint:tableviewWidth];
//    
//    NSLayoutConstraint *tableviewX =
//    [NSLayoutConstraint constraintWithItem:self.recordTableView
//                                 attribute:NSLayoutAttributeLeft
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.view
//                                 attribute:NSLayoutAttributeLeft
//                                multiplier:1.0
//                                  constant:0];
//    
//    [self.view addConstraint:tableviewX];
//    
//    NSLayoutConstraint *tableviewY =
//    [NSLayoutConstraint constraintWithItem:self.recordTableView
//                                 attribute:NSLayoutAttributeTop
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:self.view
//                                 attribute:NSLayoutAttributeTop
//                                multiplier:1.0
//                                  constant:0];
//    
//    [self.view addConstraint:tableviewY];
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
 
     self.cellFiller = self.assignmentArray[indexPath.row];
     cell.textLabel.text = self.cellFiller.assignment;
     cell.detailTextLabel.text = [self dateAsString];
     
     
 
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

-(NSString *)dateAsString{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    NSString *date = [format stringFromDate:self.cellFiller.date];
    return date;
}


@end
