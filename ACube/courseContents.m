//
//  courseContents.m
//  ACube
//
//  Created by Akshay Yadav on 11/16/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "courseContents.h"

@implementation courseContents


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.videoURL.text = @"";
    
}


- (IBAction)uploadPdfAction:(id)sender {
    
    if ([self.pdfURL.text rangeOfString:@".pdf"].location == NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid pdf format"
                                                       message: @"The URL is not a valid pdf format."
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert setTag:17];
        [alert show];
    }
    else{
    
    
    
    if ([self.pdfURL.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid URL"
                                                       message: @"The URL is empty."
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert setTag:17];
        [alert show];
        
        
    }
    
    
    else{
        Firebase *addpdfUrlToThisCourse = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/pdfURL/"]]];
        
        [addpdfUrlToThisCourse setValue:self.pdfURL.text];
        
        Firebase *changepdfStatus = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/pdfStatus"]]];
        
        
        NSString * loggedinUserURL = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedInUserdetailsURL"];
        if (loggedinUserURL) {
            
        }
        
        NSString *thisCoursesVideStatus = [[loggedinUserURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:[@"/courses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"] stringByAppendingString:@"/pdfStatus" ] ]];
        [changepdfStatus setValue:@"yesPdf"];
        
        Firebase *thisCoursespdfStatusFB = [[Firebase alloc]initWithUrl:thisCoursesVideStatus];
        
        
        [thisCoursespdfStatusFB setValue:@"yesPdf" ];
         [self.PDFaddedNotification setHidden:NO];
    }
    
    
    }
    
    
}

- (IBAction)uploadVideoAction:(id)sender {
    
    if ([self.videoURL.text rangeOfString:@"youtube.com"].location == NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid youtube video URL"
                                                       message: @"The URL is not a valid youtube video."
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert setTag:17];
        [alert show];
    }
    else{

    
    if ([self.videoURL.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid URL"
                                                       message: @"The URL is empty."
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert setTag:17];
        [alert show];

        
    }
    
    
    else{
        Firebase *addVideoUrlToThisCourse = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/videoURL/"]]];
        
        [addVideoUrlToThisCourse setValue:self.videoURL.text];
        
        Firebase *changeVideoStatus = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/videoStatus"]]];
      
       NSString * loggedinUserURL = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedInUserdetailsURL"];
        if (loggedinUserURL) {
            
        }
        
        NSString *thisCoursesVideStatus = [[loggedinUserURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:[@"/courses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"] stringByAppendingString:@"/videoStatus" ] ]];
        [changeVideoStatus setValue:@"yesVideo"];
        
        Firebase *thisCoursesVideoStatusFB = [[Firebase alloc]initWithUrl:thisCoursesVideStatus];
        
        
        [thisCoursesVideoStatusFB setValue:@"yesVideo" ];
        [self.videoAddedNotfication setHidden:NO];
        
    }
    
}



}
@end
