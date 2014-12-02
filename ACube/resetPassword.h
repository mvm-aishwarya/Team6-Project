//
//  resetPassword.h
//  ACube
//
//  Created by Akshay Yadav on 11/30/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import <Foundation/Foundation.h>



@interface resetPassword : UIViewController<UITextFieldDelegate>{
    
    NSString *fName;
    NSString *lName;
    NSString *emailForSignUp;
    NSString *password;
    NSString *confirmPassword;
    NSString *passWordresetcode;
    
    
    
}


@property (weak, nonatomic) IBOutlet UITextField *emailIDEntered;

@property (weak, nonatomic) IBOutlet UITextField *passwordResetActivationCode;


@property (weak, nonatomic) IBOutlet UITextField *passwordEntered;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordEntered;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)doneButtonAction:(id)sender;

@end
