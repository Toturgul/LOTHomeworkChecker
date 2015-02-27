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

@end

@implementation LOTDatePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.dateTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//    self.pickerDate = self.myDatePicker.date;
//    self.dateTextField.text = [NSString stringWithFormat:@"%@",self.myDatePicker.date];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)changeDate:(void (^)(id newDate))dateBlock{
    dateBlock(self.myDatePicker.date);

    
}


@end
