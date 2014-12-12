//
//  LOTRecordAssignmentVC.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/10/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTRecordAssignmentVC.h"

@interface LOTRecordAssignmentVC ()
@property (weak, nonatomic) IBOutlet UITableView *recordTableView;

@end

@implementation LOTRecordAssignmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    self.recordArray = [self.chosenCourse.students allObjects];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
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
