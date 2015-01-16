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
#import "LOTEditStudentsVC.h"

@interface LOTNewCourseViewController ()
@property (nonatomic) NSInteger editNumber;
@property (weak, nonatomic) IBOutlet UITableView *studentListTableView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
- (IBAction)doneNamesButton:(id)sender;
- (IBAction)allDoneButton:(id)sender;
- (IBAction)editButton:(id)sender;
- (IBAction)editVCButton:(id)sender;






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
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //inits self.namesArray if it is empty
    if (!self.namesForListArray) {
        self.namesForListArray = [[NSMutableArray alloc]init];
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
    [self.studentListTableView reloadData];
    
}


- (IBAction)doneNamesButton:(id)sender {
    [self.view endEditing:YES];

    
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

- (IBAction)editVCButton:(id)sender {
    
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}





- (void)completeNewCourse{
    
    //add the courseName to each student
    NSArray *tempArray = [[NSArray alloc] initWithArray:self.namesForListArray];
    int i = 0;
    for (LOTStudent *courseNameStudent in tempArray) {
        courseNameStudent.courseName = self.subjectTextField.text;
        courseNameStudent.order = [NSNumber numberWithInteger:i+1];//this may be temporary
        [self.namesForListArray replaceObjectAtIndex:i withObject:courseNameStudent];
        i++;
    }

    
    LOTRecord *newRecord = [NSEntityDescription insertNewObjectForEntityForName:@"LOTRecord" inManagedObjectContext:self.dataStore.managedObjectContext];
    newRecord.courseName = self.subjectTextField.text;
    
    
    LOTCourse *courseForList = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
    [courseForList addStudents:[NSSet setWithArray:self.namesForListArray]];
    courseForList.courseName = self.subjectTextField.text;
    courseForList.assignment = @"justForClassList";
    
    [self.dataStore save];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



 #pragma mark - Navigation
 

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     LOTEditStudentsVC *editVC = segue.destinationViewController;
     editVC.namesForListArray = self.namesForListArray;
     
     
 }
 



@end
