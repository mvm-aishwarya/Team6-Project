//
//  resetPassword.m
//  ACube
//
//  Created by Akshay Yadav on 11/30/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "resetPassword.h"

#import <MailCore/MailCore.h>
#import <Firebase/Firebase.h>

#import "AESCrypt.h"

@implementation resetPassword



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emailIDEntered.delegate = self;
    self.passwordEntered.delegate = self;
    self.confirmPasswordEntered.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



-(NSString *)encodeEmailId:(NSString*)emailid{
    
    NSString* bar = [emailid stringByReplacingOccurrencesOfString:@"@" withString:@"AtThErAtEsUb"];
    bar = [bar stringByReplacingOccurrencesOfString:@"." withString:@"DoTrEpLaCe"];
    
    return bar;
}


-(NSString *)decodeEmailId:(NSString*)emailid{
    
    NSString* bar = [emailid stringByReplacingOccurrencesOfString:@"AtThErAtEsUb" withString:@"@"];
    bar = [bar stringByReplacingOccurrencesOfString:@"DoTrEpLaCe" withString:@"."];
    
    return bar;
    
}






- (IBAction)doneButtonAction:(id)sender {
    
    
    emailForSignUp = self.emailIDEntered.text;
    
    password = self.passwordEntered.text;
    
    passWordresetcode = self.passwordResetActivationCode.text;
    
    NSString * encodedEmailID = [self encodeEmailId:emailForSignUp];
    
    NSString *encryptionKey = @"abcdefghijkl";
    
    
    NSString *encryptedData = [AESCrypt encrypt:password password:encryptionKey];
    NSLog(@"encryptedString: %@", encryptedData);
    
    NSString *decryptedString = [AESCrypt decrypt:encryptedData password:encryptionKey];
    NSLog(@"decryptedString: %@", decryptedString);
    
    
    NSLog(@"Here is ENCODED PASSWORD:");
    
    
    NSLog(@"Thats IT");
    
    
    confirmPassword = self.confirmPasswordEntered.text;
    
    
    
    if (([emailForSignUp rangeOfString:@" "].location == NSNotFound)&&([emailForSignUp rangeOfString:@"@"].location != NSNotFound)&&([emailForSignUp rangeOfString:@"."].location != NSNotFound)) {
        
        
        
        
        if ([password length]>=8) {
            
            if ([confirmPassword isEqualToString:password]) {
                
                
                
                Firebase *passwordreset = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/ActiveUsers/" stringByAppendingString:encodedEmailID ] ];
                
                
                
                
                [passwordreset observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
                    
                    if (snapshot.value == [NSNull null]) {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Email not found"
                                                                       message: @"No password requested for this email"
                                                                      delegate: self
                                                             cancelButtonTitle:@"OK"
                                                             otherButtonTitles:nil];
                        
                        [alert setTag:7];
                        [alert show];
                        
                    }
                    
                    else{
                        
                        if ([snapshot.value[@"passwordResetActivation"] isEqualToString:passWordresetcode]) {
                            
                            Firebase *userspasswordreset = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/ActiveUsers/" stringByAppendingString:[encodedEmailID stringByAppendingString:@"/passWord" ] ] ];
                            
                            [userspasswordreset setValue:encryptedData];
                            
                            
                            [self performSegueWithIdentifier:@"donepasswordreset" sender:self];
                            
                
                        }
                        else{
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Reset Code"
                                                                           message: @"Please check your reset Code."
                                                                          delegate: self
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil];
                            
                            [alert setTag:26];
                            [alert show];
                        }
            
                    }
                    
                }];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Password Mismatch"
                                                               message: @"Please check new password and its confirmation."
                                                              delegate: self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
                
                [alert setTag:26];
                [alert show];
            }
        
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid password"
                                                           message: @"Password should be atleast 8 characters long."
                                                          delegate: self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
            
            [alert setTag:26];
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Email"
                                                       message: @"Please check your email id."
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert setTag:26];
        [alert show];
    }
}
@end
