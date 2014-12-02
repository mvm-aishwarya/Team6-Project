//
//  contentManagerAddingQuiz.m
//  ACube
//
//  Created by Akshay Yadav on 11/16/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "contentManagerAddingQuiz.h"





@implementation contentManagerAddingQuiz

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    crossImage = [UIImage imageNamed:@"wrongAnswer.png"];
    
    tickImage = [UIImage imageNamed:@"correctAnswer.png"];
    
    loggedinUserURL = [[NSUserDefaults standardUserDefaults]stringForKey:@"loggedInUserdetailsURL"];
    if (loggedinUserURL) {
        
    }
    
    NSString *thisCoursesURL = [[loggedinUserURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:[@"/courses/" stringByAppendingString:[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"] ]];
    
    Firebase *thisCoursesURLFireBase = [[Firebase alloc]initWithUrl:thisCoursesURL];
    
    
    
    
    self.Q1.delegate = self;
    self.Q1A1.delegate = self;
    self.Q1A2.delegate = self;
    self.Q1A3.delegate = self;
    self.Q1A4.delegate = self;
    
    self.Q2.delegate = self;
    self.Q2A1.delegate = self;
    self.Q2A2.delegate = self;
    self.Q2A3.delegate = self;
    self.Q2A4.delegate = self;
    
    self.Q3.delegate = self;
    self.Q3A1.delegate = self;
    self.Q3A2.delegate = self;
    self.Q3A3.delegate = self;
    self.Q3A4.delegate = self;
    
    self.Q4.delegate = self;
    self.Q4A1.delegate = self;
    self.Q4A2.delegate = self;
    self.Q4A3.delegate = self;
    self.Q4A4.delegate = self;
    
    self.Q5.delegate = self;
    self.Q5A1.delegate = self;
    self.Q5A2.delegate = self;
    self.Q5A3.delegate = self;
    self.Q5A4.delegate = self;
    
    
    [thisCoursesURLFireBase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
    
        if ([snapshot.value[@"quizStatus"] isEqualToString:@"noQuiz"] ) {
            
            self.Q1.text = @"";
            self.Q1A1.text = @"";
            self.Q1A2.text = @"";
            self.Q1A3.text = @"";
            self.Q1A4.text = @"";
            Q1CA = @"noanswer";
            
            self.Q2.text = @"";
            self.Q2A1.text = @"";
            self.Q2A2.text = @"";
            self.Q2A3.text = @"";
            self.Q2A4.text = @"";
            Q2CA = @"noanswer";
            
            self.Q3.text = @"";
            self.Q3A1.text = @"";
            self.Q3A2.text = @"";
            self.Q3A3.text = @"";
            self.Q3A4.text = @"";
            Q3CA = @"noanswer";
            
            self.Q4.text = @"";
            self.Q4A1.text = @"";
            self.Q4A2.text = @"";
            self.Q4A3.text = @"";
            self.Q4A4.text = @"";
            Q4CA = @"noanswer";
            
            self.Q5.text = @"";
            self.Q5A1.text = @"";
            self.Q5A2.text = @"";
            self.Q5A3.text = @"";
            self.Q5A4.text = @"";
            Q5CA = @"noanswer";

        }
        else{
            
            
            Firebase *quizDetailsQ1 = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/quiz/question1"]]];
            
            [quizDetailsQ1 observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
                
                Q1CA = snapshot.value[@"CA"];
                self.Q1.text = snapshot.value[@"Q1"];
                self.Q1A1.text = snapshot.value[@"ans1"];
                self.Q1A2.text = snapshot.value[@"ans2"];
                self.Q1A3.text = snapshot.value[@"ans3"];
                self.Q1A4.text = snapshot.value[@"ans4"];
                
                if ([Q1CA isEqualToString:@"a"]) {
                    [self.Q1A1R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q1CA isEqualToString:@"b"]) {
                    [self.Q1A2R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q1CA isEqualToString:@"c"]) {
                    [self.Q1A3R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q1CA isEqualToString:@"d"]) {
                    [self.Q1A4R setImage:tickImage forState:UIControlStateNormal];
                }
                
            
            
            }];
            
            Firebase *quizDetailsQ2 = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/quiz/question2"]]];
            
            [quizDetailsQ2 observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
                
                Q2CA = snapshot.value[@"CA"];
                self.Q2.text = snapshot.value[@"Q2"];
                self.Q2A1.text = snapshot.value[@"ans1"];
                self.Q2A2.text = snapshot.value[@"ans2"];
                self.Q2A3.text = snapshot.value[@"ans3"];
                self.Q2A4.text = snapshot.value[@"ans4"];
                
                if ([Q2CA isEqualToString:@"a"]) {
                    [self.Q2A1R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q2CA isEqualToString:@"b"]) {
                    [self.Q2A2R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q2CA isEqualToString:@"c"]) {
                    [self.Q2A3R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q2CA isEqualToString:@"d"]) {
                    [self.Q2A4R setImage:tickImage forState:UIControlStateNormal];
                }

                
                
            }];

            Firebase *quizDetailsQ3 = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/quiz/question3"]]];
            
            [quizDetailsQ3 observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
                
                Q3CA = snapshot.value[@"CA"];
                self.Q3.text = snapshot.value[@"Q3"];
                self.Q3A1.text = snapshot.value[@"ans1"];
                self.Q3A2.text = snapshot.value[@"ans2"];
                self.Q3A3.text = snapshot.value[@"ans3"];
                self.Q3A4.text = snapshot.value[@"ans4"];
                
                if ([Q3CA isEqualToString:@"a"]) {
                    [self.Q3A1R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q3CA isEqualToString:@"b"]) {
                    [self.Q3A2R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q3CA isEqualToString:@"c"]) {
                    [self.Q3A3R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q3CA isEqualToString:@"d"]) {
                    [self.Q3A4R setImage:tickImage forState:UIControlStateNormal];
                }

                
            }];
            Firebase *quizDetailsQ4 = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/quiz/question4"]]];
            
            [quizDetailsQ4 observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
                
                Q4CA = snapshot.value[@"CA"];
                self.Q4.text = snapshot.value[@"Q4"];
                self.Q4A1.text = snapshot.value[@"ans1"];
                self.Q4A2.text = snapshot.value[@"ans2"];
                self.Q4A3.text = snapshot.value[@"ans3"];
                self.Q4A4.text = snapshot.value[@"ans4"];
                
                if ([Q4CA isEqualToString:@"a"]) {
                    [self.Q4A1R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q4CA isEqualToString:@"b"]) {
                    [self.Q4A2R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q4CA isEqualToString:@"c"]) {
                    [self.Q4A3R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q4CA isEqualToString:@"d"]) {
                    [self.Q4A4R setImage:tickImage forState:UIControlStateNormal];
                }

                
            }];
            
            Firebase *quizDetailsQ5 = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/quiz/question5"]]];
            
            [quizDetailsQ5 observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
                
                Q5CA = snapshot.value[@"CA"];
                self.Q5.text = snapshot.value[@"Q5"];
                self.Q5A1.text = snapshot.value[@"ans1"];
                self.Q5A2.text = snapshot.value[@"ans2"];
                self.Q5A3.text = snapshot.value[@"ans3"];
                self.Q5A4.text = snapshot.value[@"ans4"];
                
                
                if ([Q5CA isEqualToString:@"a"]) {
                    [self.Q5A1R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q5CA isEqualToString:@"b"]) {
                    [self.Q5A2R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q5CA isEqualToString:@"c"]) {
                    [self.Q5A3R setImage:tickImage forState:UIControlStateNormal];
                }
                if ([Q5CA isEqualToString:@"d"]) {
                    [self.Q5A4R setImage:tickImage forState:UIControlStateNormal];
                }

                
                
            }];



        }
        
    }];
    
    
    
    
}



- (IBAction)Q1A1Raction:(id)sender {
    
    
    
    
    
    Q1CA = @"a";
    [self.Q1A1R setImage:tickImage forState:UIControlStateNormal];
    [self.Q1A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q1A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q1A4R setImage:crossImage forState:UIControlStateNormal];
    
}

- (IBAction)Q1A2Raction:(id)sender {
    
    Q1CA = @"b";
    
    [self.Q1A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q1A2R setImage:tickImage forState:UIControlStateNormal];
    [self.Q1A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q1A4R setImage:crossImage forState:UIControlStateNormal];
}

- (IBAction)Q1A3Raction:(id)sender {

    Q1CA = @"c";
    
    [self.Q1A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q1A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q1A3R setImage:tickImage forState:UIControlStateNormal];
    [self.Q1A4R setImage:crossImage forState:UIControlStateNormal];
}

- (IBAction)Q1A4Raction:(id)sender {
    Q1CA = @"d";
    
    [self.Q1A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q1A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q1A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q1A4R setImage:tickImage forState:UIControlStateNormal];

}

- (IBAction)Q2A1Raction:(id)sender {
    Q2CA = @"a";
    
    [self.Q2A1R setImage:tickImage forState:UIControlStateNormal];
    [self.Q2A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q2A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q2A4R setImage:crossImage forState:UIControlStateNormal];
    
    
    

}

- (IBAction)Q2A2Raction:(id)sender {
    Q2CA = @"b";
    
    [self.Q2A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q2A2R setImage:tickImage forState:UIControlStateNormal];
    [self.Q2A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q2A4R setImage:crossImage forState:UIControlStateNormal];
    
    

}

- (IBAction)Q2A3Raction:(id)sender {

    Q2CA = @"c";

    [self.Q2A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q2A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q2A3R setImage:tickImage forState:UIControlStateNormal];
    [self.Q2A4R setImage:crossImage forState:UIControlStateNormal];
    
    
}

- (IBAction)Q2A4Raction:(id)sender {
    Q2CA = @"d";
    
    [self.Q2A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q2A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q2A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q2A4R setImage:tickImage forState:UIControlStateNormal];
    
    

}

- (IBAction)Q3A1Raction:(id)sender {
    Q3CA = @"a";
    [self.Q3A1R setImage:tickImage forState:UIControlStateNormal];
    [self.Q3A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q3A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q3A4R setImage:crossImage forState:UIControlStateNormal];
}

- (IBAction)Q3A2Raction:(id)sender {
    Q3CA = @"b";
    [self.Q3A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q3A2R setImage:tickImage forState:UIControlStateNormal];
    [self.Q3A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q3A4R setImage:crossImage forState:UIControlStateNormal];

}

- (IBAction)Q3A3Raction:(id)sender {
    Q3CA = @"c";
    [self.Q3A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q3A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q3A3R setImage:tickImage forState:UIControlStateNormal];
    [self.Q3A4R setImage:crossImage forState:UIControlStateNormal];
}

- (IBAction)Q3A4Raction:(id)sender {
    Q3CA = @"d";
    [self.Q3A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q3A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q3A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q3A4R setImage:tickImage forState:UIControlStateNormal];
}

- (IBAction)Q4A1Raction:(id)sender {
    Q4CA = @"a";
    [self.Q4A1R setImage:tickImage forState:UIControlStateNormal];
    [self.Q4A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q4A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q4A4R setImage:crossImage forState:UIControlStateNormal];
}

- (IBAction)Q4A2Raction:(id)sender {
    Q4CA = @"b";
    [self.Q4A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q4A2R setImage:tickImage forState:UIControlStateNormal];
    [self.Q4A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q4A4R setImage:crossImage forState:UIControlStateNormal];
}


- (IBAction)Q4A3Raction:(id)sender {
    Q4CA = @"c";
    [self.Q4A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q4A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q4A3R setImage:tickImage forState:UIControlStateNormal];
    [self.Q4A4R setImage:crossImage forState:UIControlStateNormal];
}

- (IBAction)Q4A4Raction:(id)sender {
    Q4CA = @"d";
    [self.Q4A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q4A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q4A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q4A4R setImage:tickImage forState:UIControlStateNormal];
}

- (IBAction)Q5A1Raction:(id)sender {
    Q5CA = @"a";
    [self.Q5A1R setImage:tickImage forState:UIControlStateNormal];
    [self.Q5A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q5A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q5A4R setImage:crossImage forState:UIControlStateNormal];
}

- (IBAction)Q5A2Raction:(id)sender {
    Q5CA = @"b";
    [self.Q5A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q5A2R setImage:tickImage forState:UIControlStateNormal];
    [self.Q5A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q5A4R setImage:crossImage forState:UIControlStateNormal];

}

- (IBAction)Q5A3Raction:(id)sender {
    Q5CA = @"c";
    [self.Q5A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q5A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q5A3R setImage:tickImage forState:UIControlStateNormal];
    [self.Q5A4R setImage:crossImage forState:UIControlStateNormal];

}

- (IBAction)Q5A4Raction:(id)sender {
    Q5CA = @"d";
    [self.Q5A1R setImage:crossImage forState:UIControlStateNormal];
    [self.Q5A2R setImage:crossImage forState:UIControlStateNormal];
    [self.Q5A3R setImage:crossImage forState:UIControlStateNormal];
    [self.Q5A4R setImage:tickImage forState:UIControlStateNormal];

}



- (IBAction)updateQuizAction:(id)sender {
    
    if ([self.Q1.text isEqualToString:@""]||[self.Q1A1.text isEqualToString:@""]||[self.Q1A2.text isEqualToString:@""]||[self.Q1A3.text isEqualToString:@""]||[self.Q1A4.text isEqualToString:@""]||[Q1CA isEqualToString:@"noanswer"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Question 1 is missing details"
                                                       message: @"Please check Question 1."
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert setTag:12];
        [alert show];
    }
    
    else{
        
        
        if ([self.Q2.text isEqualToString:@""]||[self.Q2A1.text isEqualToString:@""]||[self.Q2A2.text isEqualToString:@""]||[self.Q2A3.text isEqualToString:@""]||[self.Q2A4.text isEqualToString:@""]||[Q2CA isEqualToString:@"noanswer"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Question 2 is missing details"
                                                           message: @"Please check Question 2."
                                                          delegate: self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
            
            [alert setTag:13];
            [alert show];
        }
        else{
            if ([self.Q3.text isEqualToString:@""]||[self.Q3A1.text isEqualToString:@""]||[self.Q3A2.text isEqualToString:@""]||[self.Q3A3.text isEqualToString:@""]||[self.Q3A4.text isEqualToString:@""]||[Q3CA isEqualToString:@"noanswer"]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Question 3 is missing details"
                                                               message: @"Please check Question 3."
                                                              delegate: self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
                
                [alert setTag:14];
                [alert show];
            }
            
            else{
                if ([self.Q4.text isEqualToString:@""]||[self.Q4A1.text isEqualToString:@""]||[self.Q4A2.text isEqualToString:@""]||[self.Q4A3.text isEqualToString:@""]||[self.Q4A4.text isEqualToString:@""]||[Q4CA isEqualToString:@"noanswer"]) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Question 4 is missing details"
                                                                   message: @"Please check Question 4."
                                                                  delegate: self
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
                    
                    [alert setTag:15];
                    [alert show];
                }
                
                else{
                    if ([self.Q5.text isEqualToString:@""]||[self.Q5A1.text isEqualToString:@""]||[self.Q5A2.text isEqualToString:@""]||[self.Q5A3.text isEqualToString:@""]||[self.Q5A4.text isEqualToString:@""]||[Q5CA isEqualToString:@"noanswer"]) {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Question 2 is missing details"
                                                                       message: @"Please check Question 2."
                                                                      delegate: self
                                                             cancelButtonTitle:@"OK"
                                                             otherButtonTitles:nil];
                        
                        [alert setTag:16];
                        [alert show];
                    }
                    else{
                        
                        
                        
                        
                        NSDictionary *Ques1details = @{@"Q1":self.Q1.text, @"ans1": self.Q1A1.text, @"ans2": self.Q1A2.text, @"ans3": self.Q1A3.text, @"ans4": self.Q1A4.text, @"CA":Q1CA};
                        
                        
                        
                        NSDictionary *Ques2details = @{@"Q2":self.Q2.text, @"ans1": self.Q2A1.text, @"ans2": self.Q2A2.text, @"ans3": self.Q2A3.text, @"ans4": self.Q2A4.text, @"CA":Q2CA};

                        
                        
                        NSDictionary *Ques3details = @{@"Q3":self.Q3.text, @"ans1": self.Q3A1.text, @"ans2": self.Q3A2.text, @"ans3": self.Q3A3.text, @"ans4": self.Q3A4.text, @"CA":Q3CA};
                        
                        
                        NSDictionary *Ques4details = @{@"Q4":self.Q4.text, @"ans1": self.Q4A1.text, @"ans2": self.Q4A2.text, @"ans3": self.Q4A3.text, @"ans4": self.Q4A4.text, @"CA":Q4CA};
                        
                        
                        
                        NSDictionary *Ques5details = @{@"Q5":self.Q5.text, @"ans1": self.Q5A1.text, @"ans2": self.Q5A2.text, @"ans3": self.Q5A3.text, @"ans4": self.Q5A4.text, @"CA":Q5CA};
                        
                        
                        
                        NSDictionary * QuizDetails = @{@"question1":Ques1details, @"question2":Ques2details, @"question3":Ques3details, @"question4":Ques4details, @"question5":Ques5details};
                        
                        
                        Firebase *addDetailsToThisCourse = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/quiz/"]]];
                        
                        Firebase *changeQuizStatus = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/allCourses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"]stringByAppendingString:@"/quizStatus"]]];
                        
                        NSString *thisCoursesURL = [[loggedinUserURL stringByReplacingOccurrencesOfString:@"ActiveUsers" withString:@"CoursesManagement"]stringByAppendingString:[@"/courses/" stringByAppendingString:[[[NSUserDefaults standardUserDefaults]stringForKey:@"currentOpenCourse"] stringByAppendingString:@"/quizStatus" ] ]];
                        
                        Firebase *thisCoursesURLFireBase = [[Firebase alloc]initWithUrl:thisCoursesURL];
                        
                        [changeQuizStatus setValue:@"yesQuiz"];
                        
                        
                        [addDetailsToThisCourse setValue:QuizDetails];
                        
                        [thisCoursesURLFireBase setValue:@"yesQuiz" ];
                        
                        
                        [self performSelector:@selector(QuizAddedSuccessfully) withObject:self afterDelay:2.0 ];
                        
                        
                        
                    }
                
                }
            }
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    
    
}


-(void)QuizAddedSuccessfully{
    
    [self performSegueWithIdentifier:@"updateQuiz" sender:self];
}




@end
