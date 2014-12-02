//
//  signUpVC.h
//  ACube
//
//  Created by Akshay Yadav on 10/28/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import <Foundation/Foundation.h>



@interface signUpVC : UIViewController<UITextFieldDelegate>{
    
    NSString *fName;
    NSString *lName;
    NSString *emailForSignUp;
    NSString *password;
    NSString *confirmPassword;
    
    
}



@property (weak, nonatomic) IBOutlet UITextField *fNameEntered;
@property (weak, nonatomic) IBOutlet UITextField *lNameEntered;
@property (weak, nonatomic) IBOutlet UITextField *emailIDEntered;
@property (weak, nonatomic) IBOutlet UITextField *passwordEntered;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordEntered;

@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

- (IBAction)signUpButtonAction:(id)sender;

@end
