//
//  particularCourseVC.m
//  ACube
//
//  Created by Akshay Yadav on 11/3/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "particularCourseVC.h"

@implementation particularCourseVC


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.courseName setText:[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]];
    
    tag1ToDelete = @"";
    tag2ToDelete = @"";
    tag3ToDelete = @"";

    loggedinUserURL = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedInUserdetailsURL"];
    if (loggedinUserURL) {
        
    }
    
    NSString *particularCoursesURL = [[loggedinUserURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:[@"/courses/" stringByAppendingString:[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"] ]];
    
    Firebase *particularCoursesURLFireBase = [[Firebase alloc]initWithUrl:particularCoursesURL];
    
    
    [particularCoursesURLFireBase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
    
        if ([snapshot.value[@"deprecatedStatus"] isEqualToString:@"undeprecated"]) {
            [self.deprecateNotification setText:@"This course is NOT Deprecated"];
        }
        if ([snapshot.value[@"deprecatedStatus"] isEqualToString:@"deprecated"]) {
            [self.deprecateNotification setText:@"This course is Deprecated"];
        }
       
        if ([snapshot.value[@"releaseStatus"] isEqualToString:@"unreleased"]) {
            [self.releaseNotification setText:@"This course is NOT Released"];
        }
        if ([snapshot.value[@"releaseStatus"] isEqualToString:@"released"]) {
            [self.releaseNotification setText:@"This course is Released"];
        }
        if ([snapshot.value[@"quizStatus"] isEqualToString:@"yesQuiz"]) {
            [self.quizNotification setText:@"This course contains a quiz"];
        }
        if ([snapshot.value[@"quizStatus"] isEqualToString:@"noQuiz"]) {
            [self.quizNotification setText:@"This course does not contain Quiz"];
        }
        if ([snapshot.value[@"pdfStatus"] isEqualToString:@"yesPdf"]) {
            [self.pdfNotification setText:@"This course contains a Pdf"];
        }
        if ([snapshot.value[@"pdfStatus"] isEqualToString:@"noPdf"]) {
            [self.pdfNotification setText:@"This course does not contain a Pdf"];
        }
        if ([snapshot.value[@"videoStatus"] isEqualToString:@"yesVideo"]) {
            [self.videoNotification setText:@"This course contains a video"];
        }
        if ([snapshot.value[@"videoStatus"] isEqualToString:@"noVideo"]) {
            [self.videoNotification setText:@"This course does not contain a video"];
        }
    }];
    
    
    
}





- (IBAction)deleteCourseAction:(id)sender {
    
   NSString * listOfCoursesURL = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedInUserdetailsURL"];
    
    
    NSString *newCoursesURL = [[listOfCoursesURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:@"/courses"];
    
    NSString *currentCourseURL = [[newCoursesURL stringByAppendingString:@"/"]stringByAppendingString:[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]];
    
    
    
    Firebase *tag1DB = [[Firebase alloc]initWithUrl:[currentCourseURL stringByAppendingString:@"/tag1"]];
    
    Firebase *tag2DB = [[Firebase alloc]initWithUrl:[currentCourseURL stringByAppendingString:@"/tag2"]];
    
    Firebase *tag3DB = [[Firebase alloc]initWithUrl:[currentCourseURL stringByAppendingString:@"/tag3"]];
    
    
    
    [tag1DB observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
    
        tag1ToDelete = snapshot.value;
        
        Firebase * tag1DeleteThisURL = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allTags/" stringByAppendingString:[tag1ToDelete stringByAppendingString:[@"/" stringByAppendingString:[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]] ]] ];
        
        
        [tag1DeleteThisURL removeValue];
        
        
    }];
    
    
    
    [tag2DB observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
        
        tag2ToDelete = snapshot.value;
        
        Firebase * tag2DeleteThisURL = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allTags/" stringByAppendingString:[tag2ToDelete stringByAppendingString:[@"/" stringByAppendingString:[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]] ]] ];
        
        [tag2DeleteThisURL removeValue];
        
        
    }];
    
    
    [tag3DB observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
        
        tag3ToDelete = snapshot.value;
        
        Firebase * tag3DeleteThisURL = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allTags/" stringByAppendingString:[tag3ToDelete stringByAppendingString:[@"/" stringByAppendingString:[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]] ]] ];
        
        [tag3DeleteThisURL removeValue];
        
    }];

    
    
    Firebase *deleteThisCourse = [[Firebase alloc]initWithUrl:currentCourseURL];
    
    [deleteThisCourse removeValue];
    
    Firebase *deleteThisCourseFromCoursesDB = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]]];
    
    
    [deleteThisCourseFromCoursesDB removeValue];
    
    
     //[self performSelector:@selector(goBack) withObject:self afterDelay:3.0 ];
    [self performSegueWithIdentifier:@"deletedCourse" sender:self];
    
    
    
}

//
//-(void)goBack{
//    
//}


- (IBAction)deprecateCourseAction:(id)sender {
    
    if ([self.releaseNotification.text isEqualToString:@"This course is Released"]) {
        
        [self.deprecateNotification setText:@"This course is Deprecated"];
     
        Firebase *changedeprecatedStatus = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/deprecatedStatus"]]];
        
        NSString * loggedinUserURL = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedInUserdetailsURL"];
        if (loggedinUserURL) {
            
        }
        
        NSString *thisCoursesVideStatus = [[loggedinUserURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:[@"/courses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"] stringByAppendingString:@"/deprecatedStatus" ] ]];
        [changedeprecatedStatus setValue:@"deprecated"];
        
        Firebase *thisCoursesVideoStatusFB = [[Firebase alloc]initWithUrl:thisCoursesVideStatus];
        
        
        [thisCoursesVideoStatusFB setValue:@"deprecated" ];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Action"
                                                       message: @"Cannot deprecate unreleased course."
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert setTag:9];
        [alert show];
    }

  
    

}

- (IBAction)releaseCourseAction:(id)sender {

    [self.releaseNotification setText:@"This course is Released"];
   //  [self.notification setText:@"Released!!!"];
    Firebase *changereleasedStatus = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/releaseStatus"]]];
    
    NSString * loggedinUserURL = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedInUserdetailsURL"];
    if (loggedinUserURL) {
        
    }
    
    NSString *thisCoursesVideStatus = [[loggedinUserURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:[@"/courses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"] stringByAppendingString:@"/releaseStatus" ] ]];
    [changereleasedStatus setValue:@"released"];
    
    Firebase *thisCoursesVideoStatusFB = [[Firebase alloc]initWithUrl:thisCoursesVideStatus];
    
    
    [thisCoursesVideoStatusFB setValue:@"released" ];

}

- (IBAction)seeContentAction:(id)sender {
}
@end
