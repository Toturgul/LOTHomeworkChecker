//
//  LOTStudentListTableViewController.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 11/24/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTStudentListTableViewController.h"

@interface LOTStudentListTableViewController ()
@property (strong, nonatomic) NSArray * listOfStudents;
@end

@implementation LOTStudentListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"hi");
    self.listOfStudents = @[@"Smart Sarah", @"Stupid Sam", @"Burnout Barney", @"Brainy Brian"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return [self.listOfStudents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    static NSString * reuseIdentifier = @"programmaticCell";
    MGSwipeTableCell * cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    cell.textLabel.text = self.listOfStudents[indexPath.row];
    cell.detailTextLabel.text = @"Detail text";
    cell.delegate = self; //optional
    
    
    //configure left buttons
    cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"👍" icon:[UIImage imageNamed:@"check.png"] backgroundColor:[UIColor greenColor]]];
                            //  [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"fav.png"] backgroundColor:[UIColor blueColor]]];
    cell.leftExpansion.fillOnTrigger = YES;
    cell.leftSwipeSettings.transition = MGSwipeTransition3D;
    
    //configure right buttons
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"👎" backgroundColor:[UIColor redColor]]];
                      //    [MGSwipeButton buttonWithTitle:@"More" backgroundColor:[UIColor lightGrayColor]]];
    cell.rightExpansion.fillOnTrigger = NO;
    cell.rightSwipeSettings.transition = MGSwipeTransition3D;
    return cell;
    
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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
