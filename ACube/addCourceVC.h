//
//  addCourceVC.h
//  ACube
//
//  Created by Akshay Yadav on 11/3/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface addCourceVC : UIViewController
{
    
    NSString *loggedinUserURL;
    
}
@property (weak, nonatomic) IBOutlet UITextField *nameOfCourseTextField;
@property (weak, nonatomic) IBOutlet UIButton *addCourse;

@property (weak, nonatomic) IBOutlet UITextField *tag1;

@property (weak, nonatomic) IBOutlet UITextField *tag2;

@property (weak, nonatomic) IBOutlet UITextField *tag3;


- (IBAction)addCourseAction:(id)sender;

@end
