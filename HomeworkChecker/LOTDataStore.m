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
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"LOTCourse"];
    self.courseArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if ([self.courseArray count] == 0) {
        [self sampleData];
    }
    
    
}


- (void) sampleData {
    
    LOTCourse *sampleCourse = [NSEntityDescription insertNewObjectForEntityForName:@"LOTCourse" inManagedObjectContext:self.managedObjectContext];
    sampleCourse.courseName = @"(Example) Period 3 Biology";
    
    LOTStudent *student1 = [NSEntityDescription insertNewObjectForEntityForName:@"LOTStudent" inManagedObjectContext:self.managedObjectContext];
    student1.name = @"Summer";
    [sampleCourse addStudentsObject:student1];
    
    [self save];
    [self fetchData];
    
}




@end
