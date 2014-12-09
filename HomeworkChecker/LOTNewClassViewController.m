//
//  LOTNewClassViewController.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/7/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTNewClassViewController.h"
#import "LOTCourse.h"
#import "LOTStudent.h"
@interface LOTNewClassViewController ()
@property (nonatomic) NSInteger editNumber;
@property (weak, nonatomic) IBOutlet UITableView *addStudentsTableView;
- (IBAction)addStudentButton:(id)sender;
- (IBAction)editButton:(id)sender;
- (IBAction)doneButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *courseLabel;


@end

@implementation LOTNewClassViewController
//@synthesize addStudentsTableView, namesArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addStudentsTableView.delegate = self;
    self.addStudentsTableView.dataSource = self;
    
    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchData];
    //self.namesArray = [[NSMutableArray alloc] init];
   // self.namesArray = [[NSMutableArray alloc] initWithObjects:@"Joe",@"Tina",@"Jamal",@"Amy", nil];
    self.editNumber = 2;
    //self.title = @"Students";
   // NSLog(@"%@",self.namesArray);
    //[self.addStudentsTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.namesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"nameCell";
UITableViewCell *cell = [self.addStudentsTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    LOTStudent *newStudent = self.namesArray[indexPath.row];
    cell.textLabel.text = newStudent.name;

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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //inits self.namesArray if it is empty
    if (!self.namesArray) {
        self.namesArray = [[NSMutableArray alloc]init];
    }
    
    // Make sure the button they clicked wasn't Cancel
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        
        LOTStudent *newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.dataStore.managedObjectContext];
        newStudent.name = textField.text;
        
        self.name = textField.text;     //erase
        NSLog(@"%@", textField.text); //erase
        [self.namesArray insertObject:newStudent atIndex:0];
        [self.addStudentsTableView reloadData];
        NSLog(@"%@",self.namesArray); //erase
        
        
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"You clicked %li",buttonIndex);
    
}



- (IBAction)addStudentButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Student" message:@"Enter Student Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [alert show];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    UITextField *textField = [alert textFieldAtIndex:0];

    
}




//Puts view controller in edit mode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.addStudentsTableView setEditing:editing animated:animated ];
}


//Next two methods allow for editing of cells in the table
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.namesArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (IBAction)editButton:(id)sender {
    
    
 //turns on and off edit every other time the button is touched
    if (self.editNumber%2==0) {
        
    //[super setEditing:TRUE];
    //[self.addStudentsTableView setEditing:TRUE];
    self.editing = YES;
        self.editNumber++;
    }
    else {
       // [super setEditing:FALSE];
       // [self.addStudentsTableView setEditing:FALSE];
        self.editing = NO;
        self.editNumber++;
    }
    
}

- (IBAction)doneButton:(id)sender {
    
    //create a new LOTCourse ands stores name
    LOTCourse *newCourse = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.dataStore.managedObjectContext];
    newCourse.courseName = self.courseLabel.text;
    
    for (LOTStudent *temp in self.namesArray) {
        [newCourse addStudentsObject:temp];
    }
    
    [self.dataStore save];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

@end
