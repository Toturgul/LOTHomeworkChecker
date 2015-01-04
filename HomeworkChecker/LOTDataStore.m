//
//  LOTDataStore.m
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/8/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import "LOTDataStore.h"
#import "LOTStudent.h"
#import "LOTCourse.h"


@implementation LOTDataStore
@synthesize managedObjectContext = _managedObjectContext;


+ (instancetype)sharedHomeworkDataStore {
    static LOTDataStore *_sharedHomeworkDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHomeworkDataStore = [[LOTDataStore alloc] init];
    });
    
    return _sharedHomeworkDataStore;
}

- (void)save
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HomeworkCheck.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HomeworkCheck" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}


- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (void) fetchData {
//    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LOTCourse"];
//    self.classListArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"LOTCourse" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSString *match = @"justForClassList";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"assignment like %@",match];
    [request setPredicate:predicate];
    
    NSError *error;
    self.classListArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    //NSLog(@"matchingData %@",self.classListArray);
    
    if ([self.classListArray count] == 0) {
        [self sampleData];
    }
}



-(void) fetchRecord{
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LOTRecord"];
    self.coursesForRecordArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    

}




- (void) sampleData {
    
    LOTCourse *sampleCourse = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.managedObjectContext];
    sampleCourse.courseName = @"Period 1 U.S. History";
    sampleCourse.assignment = @"justForClassList";
    
    LOTStudent *student1 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student1.name = @"Summer";
    [sampleCourse addStudentsObject:student1];
    
    LOTStudent *student2 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student2.name = @"Alison";
    [sampleCourse addStudentsObject:student2];
    
    LOTStudent *student3 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student3.name = @"Fatima";
    [sampleCourse addStudentsObject:student3];
    
    LOTStudent *student4 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student4.name = @"Frank";
    [sampleCourse addStudentsObject:student4];
    
    LOTStudent *student5 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student5.name = @"Juan";
    [sampleCourse addStudentsObject:student5];
    
    LOTStudent *student6 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student6.name = @"Jamal";
    [sampleCourse addStudentsObject:student6];
    
    LOTStudent *student7 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student7.name = @"Kim";
    [sampleCourse addStudentsObject:student7];
    
    LOTStudent *student8 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student8.name = @"Leo";
    [sampleCourse addStudentsObject:student8];
    
    LOTStudent *student9 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student9.name = @"Diane";
    [sampleCourse addStudentsObject:student9];
    
    LOTStudent *student10 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student10.name = @"Elisa";
    [sampleCourse addStudentsObject:student10];
    
    LOTStudent *student11 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student11.name = @"David";
    [sampleCourse addStudentsObject:student11];
    
    
    
    
    [self save];
    [self fetchData];
    
}




@end
