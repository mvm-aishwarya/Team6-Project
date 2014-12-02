//
//  addCourseAsStudent.m
//  ACube
//
//  Created by Akshay Yadav on 11/14/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "addCourseAsStudent.h"
#import <Firebase/Firebase.h>

@interface  addCourseAsStudent()

@property (nonatomic) Firebase *coursesOfGivenQuery;
@property (nonatomic) Firebase *tagsOfGivenQuery;

@property (weak, nonatomic) NSString *desiredQuery;

@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation addCourseAsStudent

static NSString *cellIdentifier;


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.searchCoursetextField.delegate = self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)searchForCourse:(id)sender {
    
    if ([self.searchCoursetextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Course or tag"
                                                       message: @"Please add course name or tag."
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert setTag:20];
        [alert show];
    }
    
    
    
    else{
        
        self.desiredQuery = self.searchCoursetextField.text;
        
        
        NSString *newCoursesURL = @"https://acube.firebaseio.com/allCourses";
        NSString *newTagsURL = [@"https://acube.firebaseio.com/allTags/" stringByAppendingString:self.desiredQuery];
        NSLog(newTagsURL);
        
        
        self.coursesOfGivenQuery= [[Firebase alloc]initWithUrl:newCoursesURL];
        self.tagsOfGivenQuery = [[Firebase alloc]initWithUrl:newTagsURL];
       
        
        self.data = [[NSMutableArray alloc] init];
        [self loadDataFromFirebase];
        [self.listOfCourses reloadData];
        NSLog(@"%lu", (unsigned long)[self.data count]);
        
    }
    
    
    
}

-(void)loadDataFromFirebase
{
    
    [self.coursesOfGivenQuery observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@", snapshot.value);
        
        if ([snapshot.name isEqualToString:self.desiredQuery] && [snapshot.value[@"releaseStatus"]isEqualToString:@"released"]) {
            [self.data addObject:snapshot.name];
            NSLog(snapshot.value[@"releaseStatus"]);
            
        }
        
        
        
        NSLog(@"%lu", (unsigned long)[self.data count]);
        [self.listOfCourses reloadData];
        
        
    }];
    
    [self.tagsOfGivenQuery observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@", snapshot.value);
        
        
        
        
        Firebase *courseFromTags = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[snapshot.name stringByAppendingString:@"/releaseStatus"] ]];
        [courseFromTags observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *courseReleaseStatus){
        
            if ([courseReleaseStatus.value isEqualToString:@"released"]) {
                [self.data addObject:snapshot.name];
                
                
                
                NSLog(@"%lu", (unsigned long)[self.data count]);
                [self.listOfCourses reloadData];
                
            }
        
        }];
        
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
    
    NSLog(@"this thing works");
    [self performSegueWithIdentifier:@"clickedOnCourse" sender:self];
    
    
    
}

@end
