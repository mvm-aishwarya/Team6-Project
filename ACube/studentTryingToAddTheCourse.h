//
//  studentTryingToAddTheCourse.h
//  ACube
//
//  Created by Akshay Yadav on 11/17/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface studentTryingToAddTheCourse : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *courseName;

@property (weak, nonatomic) IBOutlet UILabel *tag1;

@property (weak, nonatomic) IBOutlet UILabel *tag2;

@property (weak, nonatomic) IBOutlet UILabel *tag3;

@property (weak, nonatomic) IBOutlet UILabel *deprecatedStatus;

@property (weak, nonatomic) IBOutlet UIButton *addThisCourseButton;

- (IBAction)addThisCourseAction:(id)sender;

@end
