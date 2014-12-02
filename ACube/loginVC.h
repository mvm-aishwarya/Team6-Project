//
//  loginVC.h
//  ACube
//
//  Created by Akshay Yadav on 11/2/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface loginVC : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSString *currentLoggedInUserID;
    NSString *roleOfLogegdInUser;
    
    NSString *listOfCoursesURL;
    
    
}


@property (weak, nonatomic) IBOutlet UILabel *FirstNameOfLoggedInUser;

@property (weak, nonatomic) IBOutlet UITableView *thisStudentsCourse;



@end
