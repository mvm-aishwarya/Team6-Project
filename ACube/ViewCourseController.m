//
//  ViewCourseController.m
//  ACube
//
//  Created by Akshay Yadav on 11/29/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "ViewCourseController.h"

@implementation ViewCourseController{
    
    
}
    
-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.pdfVideoswitch isOn];
    nameOfCourse = [[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"];
    
    Firebase *currentCourseDetails = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/"stringByAppendingString:nameOfCourse]];
    
    [currentCourseDetails observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
    
        videoURL = snapshot.value[@"videoURL"];
        NSLog(videoURL);
        
        pdfURL = snapshot.value[@"pdfURL"];
        
        url = [NSURL URLWithString:videoURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_pdfVideoWebView loadRequest:request];
        
        
    }];
  
    
}


-(void)putContentToWebView{
    
    
}




- (IBAction)pdfVideoSwitchAction:(id)sender {
    
    if ([self.pdfVideoswitch isOn] ) {
        NSLog(@"changing to PDF");
        url = [NSURL URLWithString:videoURL];
        
    }
    else{
        NSLog(@"changing to Video");
        url = [NSURL URLWithString:pdfURL];
    }
        
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_pdfVideoWebView loadRequest:request];
    
    
    
}
@end
