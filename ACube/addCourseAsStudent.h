//
//  addCourseAsStudent.h
//  ACube
//
//  Created by Akshay Yadav on 11/14/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface addCourseAsStudent : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    NSString *thisUsersRole;
    
    NSString *listOfCoursesURL;
    
}
@property (weak, nonatomic) IBOutlet UITextField *searchCoursetextField;

- (IBAction)searchForCourse:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *listOfCourses;





@end
