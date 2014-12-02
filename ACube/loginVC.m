//
//  loginVC.m
//  ACube
//
//  Created by Akshay Yadav on 11/2/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "loginVC.h"
#import <Firebase/Firebase.h>


@interface loginVC()


@property (nonatomic) Firebase *coursesOfLoggedInUser;
@property (weak, nonatomic) NSString *loggedInUsersNameLocal;

@property (nonatomic,strong) NSMutableArray *data;


@end


@implementation loginVC

static NSString *cellIdentifier;


- (void)viewDidLoad{
    
    [super viewDidLoad];
// Do any additional setup after loading the view, typically from a nib.

    listOfCoursesURL = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedInUserdetailsURL"];
    
    Firebase *userDetails = [[Firebase alloc]initWithUrl:listOfCoursesURL];
    
    [userDetails observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *userName){
    
        
        [self.FirstNameOfLoggedInUser setText:userName.value[@"firstName"]];
        
    
    
    }];
    
    if (listOfCoursesURL) {
        
        
    }


    NSString *newCoursesURL = [[listOfCoursesURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:@"/courses"];
    
    
    self.coursesOfLoggedInUser = [[Firebase alloc]initWithUrl:newCoursesURL];
    
    self.data = [[NSMutableArray alloc] init];
    [self loadDataFromFirebase];
    [self.thisStudentsCourse reloadData];
    NSLog(@"%lu", (unsigned long)[self.data count]);


}


-(void)loadDataFromFirebase
{
    
    [self.coursesOfLoggedInUser observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@", snapshot.value);
        [self.data addObject:snapshot.name];
        NSLog(@"%lu", (unsigned long)[self.data count]);
        [self.thisStudentsCourse reloadData];
        
        
    }];
    
    cellIdentifier = @"rowCell";
    
    [self.thisStudentsCourse registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    NSLog(@"%@",self.data);
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    
    //------attempting---thumbnail---canvas-------
    
    
    //  UIImageView *tempImage;
    
    
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    //    UIImage *image = [UIImage imageNamed: @"Eraser.png"];
    //    [cell.imageView setImage:image] ;
    
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString * nameOfCourse;
//    
//    nameOfCourse = [self.data objectAtIndex:indexPath.row];
//    
//    
//    
//    [[NSUserDefaults standardUserDefaults]setValue:nameOfCourse forKey:@"currentOpenCourse"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//    
//    
//    [self performSegueWithIdentifier:@"particularCourseSegue" sender:self];
//    
//
    
    NSLog(@"Youpressed");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
