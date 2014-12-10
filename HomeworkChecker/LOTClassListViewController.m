//
//  LOTClassListViewController.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/7/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTClassListViewController.h"
#import "LOTCourse.h"
#import "LOTStudentListViewController.h"
@interface LOTClassListViewController () 
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNewClassButton;
@property (weak, nonatomic) IBOutlet UITableView *classListTableView;

@end

@implementation LOTClassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.classListTableView.delegate = self;
    self.classListTableView.dataSource = self;
    
    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchData];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    self.classListTableView.backgroundColor = [UIColor whiteColor];
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    [self.dataStore fetchData];
    [self.classListTableView reloadData];
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
    
    static NSString *cellIdentifier = @"classCell";
    UITableViewCell *cell = [self.classListTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    LOTCourse *cellFiller = self.dataStore.courseArray[indexPath.row];
    cell.textLabel.text = cellFiller.courseName;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
    
}












#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier  isEqual:@"goToClass"]) {
    
    NSIndexPath *chosenIndexPath = [self.classListTableView indexPathForSelectedRow];
    LOTCourse *chosenCourse = self.dataStore.courseArray[chosenIndexPath.row];
    LOTStudentListViewController *studentListVC = segue.destinationViewController;
    studentListVC.chosenCourse = chosenCourse;
    }
    
}


@end
