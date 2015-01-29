//
//  LOTCustomClass.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/16/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import "LOTCustomClass.h"
#import "LOTDataStore.h"

@implementation LOTCustomClass

-(NSArray *)findSpecificEntity:(NSString *)entity byMatchingThisAttribute:(NSString *)attribute withThisTerm:(NSString *)term{

    self.dataStore = [LOTDataStore sharedHomeworkDataStore];
    [self.dataStore fetchData];

    //This will find and fetch a specific object in core data
    NSEntityDescription *entDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:self.dataStore.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like %@", attribute, term];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchingData = [self.dataStore.managedObjectContext executeFetchRequest:request error:&error];
    NSLog(@"matchingData has %lu objects",[matchingData count]);
    return matchingData;


//    self.courseSavedToCoreData = matchingData[0];
//    NSLog(@"courseSavedToCoreDate name: %@",self.courseSavedToCoreData.courseName);
//    NSLog(@"# in matchingData %lu",[matchingData count]);
//    self.courseSavedToCoreData.assignment = self.assignmentTextField.text;
//    //Date won't reflect what people type in
//    self.courseSavedToCoreData.date = [NSDate date];
//
//    for (LOTStudent *temp in self.listOfStudents) {
//        NSLog(@"# students courseSavedToCoreData: %lu",[self.courseSavedToCoreData.students count]);
//        temp.assignment = self.assignmentTextField.text;
//        temp.date = [NSDate date];
//
//        [self.courseSavedToCoreData addStudentsObject:temp];
//    }
//
//}
}

-(NSString *)todaysDateAsString{

    NSDate *today = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    NSString *date = [format stringFromDate:today];
    return date;
    
}



@end
