//
//  contentManagerAddingQuiz.h
//  ACube
//
//  Created by Akshay Yadav on 11/16/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface contentManagerAddingQuiz : UIViewController<UITextFieldDelegate>{
    
    
    
    UIImage *crossImage;
    
    UIImage *tickImage;
    
    NSString *loggedinUserURL;
    
    NSString * Q1CA;
    NSString * Q2CA;
    NSString * Q3CA;
    NSString * Q4CA;
    NSString * Q5CA;
    
}




@property (weak, nonatomic) IBOutlet UITextField *Q1;
@property (weak, nonatomic) IBOutlet UITextField *Q1A1;
@property (weak, nonatomic) IBOutlet UITextField *Q1A2;
@property (weak, nonatomic) IBOutlet UITextField *Q1A3;
@property (weak, nonatomic) IBOutlet UITextField *Q1A4;
@property (weak, nonatomic) IBOutlet UIButton *Q1A1R;
@property (weak, nonatomic) IBOutlet UIButton *Q1A2R;
@property (weak, nonatomic) IBOutlet UIButton *Q1A3R;
@property (weak, nonatomic) IBOutlet UIButton *Q1A4R;


@property (weak, nonatomic) IBOutlet UITextField *Q2;
@property (weak, nonatomic) IBOutlet UITextField *Q2A1;
@property (weak, nonatomic) IBOutlet UITextField *Q2A2;
@property (weak, nonatomic) IBOutlet UITextField *Q2A3;
@property (weak, nonatomic) IBOutlet UITextField *Q2A4;
@property (weak, nonatomic) IBOutlet UIButton *Q2A1R;
@property (weak, nonatomic) IBOutlet UIButton *Q2A2R;
@property (weak, nonatomic) IBOutlet UIButton *Q2A3R;
@property (weak, nonatomic) IBOutlet UIButton *Q2A4R;


@property (weak, nonatomic) IBOutlet UITextField *Q3;
@property (weak, nonatomic) IBOutlet UITextField *Q3A1;
@property (weak, nonatomic) IBOutlet UITextField *Q3A2;
@property (weak, nonatomic) IBOutlet UITextField *Q3A3;
@property (weak, nonatomic) IBOutlet UITextField *Q3A4;
@property (weak, nonatomic) IBOutlet UIButton *Q3A1R;
@property (weak, nonatomic) IBOutlet UIButton *Q3A2R;
@property (weak, nonatomic) IBOutlet UIButton *Q3A3R;
@property (weak, nonatomic) IBOutlet UIButton *Q3A4R;


@property (weak, nonatomic) IBOutlet UITextField *Q4;
@property (weak, nonatomic) IBOutlet UITextField *Q4A1;
@property (weak, nonatomic) IBOutlet UITextField *Q4A2;
@property (weak, nonatomic) IBOutlet UITextField *Q4A3;
@property (weak, nonatomic) IBOutlet UITextField *Q4A4;
@property (weak, nonatomic) IBOutlet UIButton *Q4A1R;
@property (weak, nonatomic) IBOutlet UIButton *Q4A2R;
@property (weak, nonatomic) IBOutlet UIButton *Q4A3R;
@property (weak, nonatomic) IBOutlet UIButton *Q4A4R;


@property (weak, nonatomic) IBOutlet UITextField *Q5;
@property (weak, nonatomic) IBOutlet UITextField *Q5A1;
@property (weak, nonatomic) IBOutlet UITextField *Q5A2;
@property (weak, nonatomic) IBOutlet UITextField *Q5A3;
@property (weak, nonatomic) IBOutlet UITextField *Q5A4;
@property (weak, nonatomic) IBOutlet UIButton *Q5A1R;
@property (weak, nonatomic) IBOutlet UIButton *Q5A2R;
@property (weak, nonatomic) IBOutlet UIButton *Q5A3R;
@property (weak, nonatomic) IBOutlet UIButton *Q5A4R;





- (IBAction)Q1A1Raction:(id)sender;
- (IBAction)Q1A2Raction:(id)sender;
- (IBAction)Q1A3Raction:(id)sender;
- (IBAction)Q1A4Raction:(id)sender;

- (IBAction)Q2A1Raction:(id)sender;
- (IBAction)Q2A2Raction:(id)sender;
- (IBAction)Q2A3Raction:(id)sender;
- (IBAction)Q2A4Raction:(id)sender;

- (IBAction)Q3A1Raction:(id)sender;
- (IBAction)Q3A2Raction:(id)sender;
- (IBAction)Q3A3Raction:(id)sender;
- (IBAction)Q3A4Raction:(id)sender;


- (IBAction)Q4A1Raction:(id)sender;
- (IBAction)Q4A2Raction:(id)sender;
- (IBAction)Q4A3Raction:(id)sender;
- (IBAction)Q4A4Raction:(id)sender;


- (IBAction)Q5A1Raction:(id)sender;
- (IBAction)Q5A2Raction:(id)sender;
- (IBAction)Q5A3Raction:(id)sender;
- (IBAction)Q5A4Raction:(id)sender;





- (IBAction)updateQuizAction:(id)sender;










@end
