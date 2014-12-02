//
//  studentTryingToAddTheCourse.m
//  ACube
//
//  Created by Akshay Yadav on 11/17/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "studentTryingToAddTheCourse.h"


@implementation studentTryingToAddTheCourse



-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.courseName setText:[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]];
    
    Firebase *currentCourseDetails = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString: [[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]]];
    
    [currentCourseDetails observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
    
        [self.tag1 setText:snapshot.value[@"tag1"]];
        [self.tag2 setText:snapshot.value[@"tag2"]];
        [self.tag3 setText:snapshot.value[@"tag3"]];
        
        if ([snapshot.value[@"deprecatedStatus"] isEqualToString:@"deprecated"]) {
            [self.deprecatedStatus setText:@"This course is deprecated"];
        }
        
    
    
    }];
     
     
   
    
    
    
}




- (IBAction)addThisCourseAction:(id)sender {
    
    
    NSString *loggedInUserURL = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedInUserdetailsURL"];
    
    NSString *newCoursesURL = [[loggedInUserURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:@"/courses"];
    
    NSLog(loggedInUserURL);
    
    
}
@end
