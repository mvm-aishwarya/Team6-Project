//
//  addCourceVC.m
//  ACube
//
//  Created by Akshay Yadav on 11/3/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "addCourceVC.h"

@implementation addCourceVC


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    loggedinUserURL = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedInUserdetailsURL"];
    if (loggedinUserURL) {

        
        
}

    

}

- (IBAction)addCourseAction:(id)sender {
    
    
    if ([self.nameOfCourseTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Course Name"
                                                       message: @"Please add valid course name."
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert setTag:18];
        [alert show];
        
    }
    else{
        if ([self.tag1.text isEqualToString:@""]||[self.tag2.text isEqualToString:@""]||[self.tag3.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Insufficient tags"
                                                           message: @"Please add all 3 tags to the course."
                                                          delegate: self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
            
            [alert setTag:19];
            [alert show];
        }
        
        else{
            NSString *nameOfCourse = self.nameOfCourseTextField.text.lowercaseString;
            
            Firebase *courseTryingToAdd = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:nameOfCourse]];
            
            [courseTryingToAdd observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
                
                if (snapshot.value == [NSNull null]) {
                    NSString *newCoursesURL = [[loggedinUserURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:@"/courses"];
                    
                    
                    Firebase *userCourseDetails =[[Firebase alloc]initWithUrl:newCoursesURL];
                    
                    Firebase *particularCourseDetails = [userCourseDetails childByAppendingPath:nameOfCourse];
                    
                    NSDictionary *tagDictionary = @{@"tag1":self.tag1.text.lowercaseString, @"tag2":self.tag2.text.lowercaseString, @"tag3":self.tag3.text.lowercaseString, @"releaseStatus":@"unreleased", @"deprecatedStatus":@"undeprecated",@"quizStatus":@"noQuiz",@"pdfStatus":@"noPdf",@"videoStatus":@"noVideo",@"pdfURL":@"http://myweb.uiowa.edu/ayadv/contentMissing.html",@"videoURL":@"http://myweb.uiowa.edu/ayadv/contentMissing.html"};
                    
                    
                    [particularCourseDetails setValue:tagDictionary];
                    
                    Firebase *allCoursesFireBase = [[Firebase alloc] initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:nameOfCourse ]];
                    
                    [allCoursesFireBase setValue:tagDictionary];
                    
                    
                    
                    Firebase *tag1DataBase = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allTags/" stringByAppendingString:[self.tag1.text.lowercaseString stringByAppendingString:[@"/" stringByAppendingString:nameOfCourse]] ] ];
                    
                    
                    [tag1DataBase setValue:@"exists"];
                    
                    
                    Firebase *tag2DataBase = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allTags/" stringByAppendingString:[self.tag2.text.lowercaseString stringByAppendingString:[@"/" stringByAppendingString:nameOfCourse]] ] ];
                    
                    
                    [tag2DataBase setValue:@"exists"];
                    
                    
                    
                    Firebase *tag3DataBase = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allTags/" stringByAppendingString:[self.tag3.text.lowercaseString stringByAppendingString:[@"/" stringByAppendingString:nameOfCourse]] ] ];
                    
                    
                    [tag3DataBase setValue:@"exists"];
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    [self performSegueWithIdentifier:@"addCourseSucessful" sender:self];
                    
                    
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Course already Exists"
                                                                   message: @"Course with this name already exists."
                                                                  delegate: self
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
                    
                    [alert setTag:11];
                    [alert show];
                }
                
                
            }];
        }
    }
    
    
   
    
    
    
    
}
    

@end
