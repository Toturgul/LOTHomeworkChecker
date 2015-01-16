//
//  LOTCustomClass.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/16/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import "LOTCustomClass.h"

@implementation LOTCustomClass

+(void)findSpecificEntity:(NSString *)entity byMatchingThisAttribute:(NSString *)attribute withThisTerm:(NSString *)term{


//
//    //This will find and fetch a specific object in core data
//    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:entity inManagedObjectContext:self.dataStore.managedObjectContext];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entitydesc];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"assignment like %@",matchingString];
//    [request setPredicate:predicate];
//    NSError *error;
//    NSArray *matchingData = [self.dataStore.managedObjectContext executeFetchRequest:request error:&error];
//
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

@end
