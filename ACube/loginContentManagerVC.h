//
//  loginContentManagerVC.h
//  ACube
//
//  Created by Akshay Yadav on 11/3/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>


@interface loginContentManagerVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSString *thisUsersRole;
    
    NSString *listOfCoursesURL;
}





@property (weak, nonatomic) IBOutlet UIButton *addCourseButtonOutlet;

- (IBAction)addCourseButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *listOfCourses;

@property (weak, nonatomic) IBOutlet UILabel *firstNameOfLoggedInUser;





@end
