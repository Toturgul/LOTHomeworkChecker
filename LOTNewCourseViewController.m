//
//  LOTNewCourseViewController.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/6/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import "LOTNewCourseViewController.h"
#import "LOTCourse.h"
#import "LOTRecord.h"
#import "LOTStudent.h"

@interface LOTNewCourseViewController ()
@property (nonatomic) NSInteger editNumber;
@property (weak, nonatomic) IBOutlet UITableView *studentListTableView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
- (IBAction)doneNamesButton:(id)sender;
- (IBAction)allDoneButton:(id)sender;
- (IBAction)editButton:(id)sender;






@end

@implementation LOTNewCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.studentListTableView.delegate = self;
    self.studentListTableView.dataSource = self;
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.subjectTextField.delegate = self;
    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchData];
    [self.subjectTextField becomeFirstResponder];
    self.editNumber = 2;
    
    
    // Do any additional setup after loading the view.
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
    
    static NSString *cellIdentifier = @"studentCell";
    UITableViewCell *cell = [self.studentListTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    LOTStudent *studentOnList = self.namesForListArray[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",studentOnList.firstName, studentOnList.lastName];
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //inits self.namesArray if it is empty
    if (!self.namesForListArray) {
        self.namesForListArray = [[NSMutableArray alloc]init];
        self.namesForRecordArray = [[NSMutableArray alloc] init];
    }
    
    if (textField == self.subjectTextField) {
        [self.firstNameTextField becomeFirstResponder];
    }
    
    if (textField == self.firstNameTextField) {
        [self.lastNameTextField becomeFirstResponder];
    }
    if (textField == self.lastNameTextField) {
        [self createAndSaveStudent];
        textField.text = @"";
        [self.firstNameTextField becomeFirstResponder];
        
    }
    

    
    return YES;
}

-(void)createAndSaveStudent{
    LOTStudent *newStudentForList = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.dataStore.managedObjectContext];
    newStudentForList.firstName = self.firstNameTextField.text;
    newStudentForList.lastName = self.lastNameTextField.text;
    [self.namesForListArray insertObject:newStudentForList atIndex:0];
    
    LOTStudent *newStudentForRecord = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.dataStore.managedObjectContext];
    newStudentForRecord.firstName = self.firstNameTextField.text;
    newStudentForRecord.lastName = self.lastNameTextField.text;
    [self.namesForRecordArray insertObject:newStudentForRecord atIndex:0];
    
    [self.studentListTableView reloadData];
    
}


- (IBAction)doneNamesButton:(id)sender {
    NSLog(@"button touched");
    [self.subjectTextField resignFirstResponder];
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    
}

- (IBAction)allDoneButton:(id)sender {
    [self completeNewCourse];
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 }];
    
}

- (IBAction)editButton:(id)sender {
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
    [self.studentListTableView setEditing:editing animated:animated ];
}


//Next two methods allow for editing of cells in the table
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.namesForListArray removeObjectAtIndex:indexPath.row];
        [self.namesForRecordArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}





- (void)completeNewCourse{
    LOTRecord *newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"LOTRecord" inManagedObjectContext:self.dataStore.managedObjectContext];
    newRecord.courseName = self.subjectTextField.text;
    
    LOTCourse *courseForRecord = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
    courseForRecord.courseName = self.subjectTextField.text;
    [courseForRecord addStudents:[NSSet setWithArray:self.namesForRecordArray]];
    [newRecord addCoursesObject:courseForRecord];
    
    LOTCourse *courseForList = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
    [courseForList addStudents:[NSSet setWithArray:self.namesForListArray]];
    courseForList.courseName = self.subjectTextField.text;
    courseForList.assignment = @"justForClassList";
    
    [self.dataStore save];
    
}

@end
