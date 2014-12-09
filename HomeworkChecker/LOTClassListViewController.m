//
//  LOTClassListViewController.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/7/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTClassListViewController.h"
#import "LOTCourse.h"
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
