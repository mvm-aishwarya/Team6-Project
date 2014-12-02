//
//  particularCourseVC.h
//  ACube
//
//  Created by Akshay Yadav on 11/3/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface particularCourseVC : UIViewController{
    
    NSString *tag1ToDelete;
    NSString *tag2ToDelete;
    NSString *tag3ToDelete;
    
    NSString *loggedinUserURL;
    
    
}
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UIButton *DeleteCourse;
@property (weak, nonatomic) IBOutlet UIButton *DeprecateCourse;
@property (weak, nonatomic) IBOutlet UIButton *ReleaseCourse;
@property (weak, nonatomic) IBOutlet UIButton *seeContentsButton;


@property (weak, nonatomic) IBOutlet UILabel *deprecateNotification;

@property (weak, nonatomic) IBOutlet UILabel *releaseNotification;

@property (weak, nonatomic) IBOutlet UILabel *quizNotification;

@property (weak, nonatomic) IBOutlet UILabel *pdfNotification;

@property (weak, nonatomic) IBOutlet UILabel *videoNotification;



- (IBAction)deleteCourseAction:(id)sender;

- (IBAction)deprecateCourseAction:(id)sender;

- (IBAction)releaseCourseAction:(id)sender;

- (IBAction)seeContentAction:(id)sender;

@end
