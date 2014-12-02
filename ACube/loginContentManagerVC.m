//
//  loginContentManagerVC.m
//  ACube
//
//  Created by Akshay Yadav on 11/3/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "loginContentManagerVC.h"
#import <Firebase/Firebase.h>


@interface loginContentManagerVC()


@property (nonatomic) Firebase *coursesOfLoggedInUser;
@property (weak, nonatomic) NSString *loggedInUsersNameLocal;

@property (nonatomic,strong) NSMutableArray *data;

@end


@implementation loginContentManagerVC


static NSString *cellIdentifier;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
  
    listOfCoursesURL = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedInUserdetailsURL"];
    
    
    
    if (listOfCoursesURL) {
        
        
    }
    
    Firebase *getFirstName = [[Firebase alloc]initWithUrl:listOfCoursesURL];
    [getFirstName observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
    
        [self.firstNameOfLoggedInUser setText:snapshot.value[@"firstName"]];
    
    } ];
    
    NSString *newCoursesURL = [[listOfCoursesURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:@"/courses"];
    
    
    self.coursesOfLoggedInUser = [[Firebase alloc]initWithUrl:newCoursesURL];

    self.data = [[NSMutableArray alloc] init];
    [self loadDataFromFirebase];
    [self.listOfCourses reloadData];
    NSLog(@"%lu", (unsigned long)[self.data count]);
    

    
}



-(void)loadDataFromFirebase
{
    
    [self.coursesOfLoggedInUser observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@", snapshot.value);
        [self.data addObject:snapshot.name];
        NSLog(@"%lu", (unsigned long)[self.data count]);
        [self.listOfCourses reloadData];
        
        
    }];
    
    cellIdentifier = @"rowCell";
    
    [self.listOfCourses registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
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
    
    NSString * nameOfCourse;
    
    nameOfCourse = [self.data objectAtIndex:indexPath.row];
    
  
    
    [[NSUserDefaults standardUserDefaults]setValue:nameOfCourse forKey:@"currentOpenCourse"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [self performSegueWithIdentifier:@"particularCourseSegue" sender:self];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)addCourseButton:(id)sender {
    
    NSLog(thisUsersRole);

    

    
}
@end
