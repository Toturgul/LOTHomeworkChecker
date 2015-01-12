//
//  LOTEditStudentsVC.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/11/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import "LOTEditStudentsVC.h"

@interface LOTEditStudentsVC ()
@property (weak, nonatomic) IBOutlet UITableView *studentTableView;
- (IBAction)deleteButton:(id)sender;
- (IBAction)aZButton:(id)sender;
- (IBAction)zAButton:(id)sender;
- (IBAction)addButton:(id)sender;
- (IBAction)rearrangeButton:(id)sender;
- (IBAction)doneButton:(id)sender;



@end

@implementation LOTEditStudentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.studentTableView.delegate = self;
    self.studentTableView.dataSource = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentCell" forIndexPath:indexPath];
    return cell;
}




- (IBAction)deleteButton:(id)sender {
}

- (IBAction)aZButton:(id)sender {
}

- (IBAction)zAButton:(id)sender {
}

- (IBAction)addButton:(id)sender {
}

- (IBAction)rearrangeButton:(id)sender {
}

- (IBAction)doneButton:(id)sender {
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
