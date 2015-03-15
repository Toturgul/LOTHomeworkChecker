//
//  LOTDatePickerVC.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 2/5/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import "LOTDatePickerVC.h"

@interface LOTDatePickerVC ()
- (IBAction)cancelButton:(id)sender;
- (IBAction)saveButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;

@property (strong, nonatomic) LOTCustomClass *customClass;
@property (strong, nonatomic) LOTCourse *currentCourse;
@end

@implementation LOTDatePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customClass = [[LOTCustomClass alloc]init];
    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchRecord];

    self.currentCourse = [[self.customClass findSpecificEntity:@"LOTCourse"
                                             byMatchingThisAttribute:@"assignment"
                                                        withThisTerm:@"id"] lastObject];
    
    
    NSLog(@"current course %@",self.currentCourse);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButton:(id)sender {
    
    
    
    
    NSLog(@"Date: %@",self.myDatePicker.date);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(id)sender {

    self.currentCourse.date = self.myDatePicker.date;
    
    NSLog(@"Date: %@",self.myDatePicker.date);
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
