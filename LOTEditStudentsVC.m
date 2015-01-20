//
//  LOTEditStudentsVC.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/11/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import "LOTEditStudentsVC.h"
#import "LOTStudent.h"

@interface LOTEditStudentsVC ()
@property (nonatomic) NSInteger editNumber;
@property (weak, nonatomic) IBOutlet UITableView *studentTableView;
- (IBAction)deleteButton:(id)sender;
- (IBAction)aZButton:(id)sender;
- (IBAction)zAButton:(id)sender;
- (IBAction)addButton:(id)sender;
- (IBAction)rearrangeButton:(id)sender;
- (IBAction)doneButton:(id)sender;
- (IBAction)respellButton:(id)sender;




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
    
    return [self.namesForListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentCell" forIndexPath:indexPath];
    LOTStudent *studentOnList = self.namesForListArray[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",studentOnList.firstName, studentOnList.lastName];
    
    
    return cell;
}




- (IBAction)deleteButton:(id)sender {
    //turns on and off edit every other time the button is touched
    if (self.editNumber%2==0) {
        self.editing = YES;
        self.editNumber++;
    }
    else {
        self.editing = NO;
        self.editNumber++;
    }
    
}

//Puts view controller in edit mode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.studentTableView setEditing:editing animated:animated ];
}


//Next two methods allow for editing of cells in the table
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.namesForListArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}


//Next two methods allow cells to be rearranged
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = self.namesForListArray[sourceIndexPath.row];
    [self.namesForListArray removeObjectAtIndex:sourceIndexPath.row];
    [self.namesForListArray insertObject:stringToMove atIndex:destinationIndexPath.row];
}


- (IBAction)aZButton:(id)sender {
    NSSortDescriptor *lastNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *firstNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
    [self.namesForListArray sortUsingDescriptors:@[lastNameSortDescriptor,firstNameSortDescriptor]];
    [self.studentTableView reloadData];
}

- (IBAction)zAButton:(id)sender {
    NSSortDescriptor *lastNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:NO];
    NSSortDescriptor *firstNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:NO];
    [self.namesForListArray sortUsingDescriptors:@[lastNameSortDescriptor, firstNameSortDescriptor]];
    [self.studentTableView reloadData];
}

- (IBAction)addButton:(id)sender {
}

- (IBAction)rearrangeButton:(id)sender {
}

- (IBAction)doneButton:(id)sender {
    
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)respellButton:(id)sender {
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
