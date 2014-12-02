//
//  signUpVC.m
//  ACube
//
//  Created by Akshay Yadav on 10/28/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "signUpVC.h"
#import <MailCore/MailCore.h>
#import <Firebase/Firebase.h>

#import "AESCrypt.h"



@implementation signUpVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fNameEntered.delegate = self;
    self.lNameEntered.delegate = self;
    self.emailIDEntered.delegate = self;
    self.passwordEntered.delegate = self;
    self.confirmPasswordEntered.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}










-(NSString *)activationCodeGenerator{
    
    NSString *activationCode = @"";
    
    NSArray *listOfOptions = [NSArray arrayWithObjects:@"1",@"2",@"3",@"",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",nil];
    
    
    
    for (int i=0; i<8; i++) {
        int randonIndex = arc4random()%[listOfOptions count];
        NSString *aDigit = [listOfOptions objectAtIndex:randonIndex];
        
        activationCode = [activationCode stringByAppendingString:aDigit];
    }
    
    return activationCode;
    
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




- (IBAction)signUpButtonAction:(id)sender {
    
    fName = self.fNameEntered.text;
    lName = self.lNameEntered.text;
    emailForSignUp = self.emailIDEntered.text;
    
    password = self.passwordEntered.text;
    
    
    
    NSString *encryptionKey = @"abcdefghijkl";
    
    
    NSString *encryptedData = [AESCrypt encrypt:password password:encryptionKey];
    NSLog(@"encryptedString: %@", encryptedData);
    
    NSString *decryptedString = [AESCrypt decrypt:encryptedData password:encryptionKey];
    NSLog(@"decryptedString: %@", decryptedString);
    
    
    NSLog(@"Here is ENCODED PASSWORD:");
    
    
    NSLog(@"Thats IT");
    
    
    confirmPassword = self.confirmPasswordEntered.text;
    
   
    
    if (([fName length] != 0)&&([fName rangeOfString:@" "].location == NSNotFound)&&([fName rangeOfString:@"0"].location == NSNotFound)&&([fName rangeOfString:@"1"].location == NSNotFound)&&([fName rangeOfString:@"2"].location == NSNotFound)&&([fName rangeOfString:@"3"].location == NSNotFound)&&([fName rangeOfString:@"4"].location == NSNotFound)&&([fName rangeOfString:@"5"].location == NSNotFound)&&([fName rangeOfString:@"6"].location == NSNotFound)&&([fName rangeOfString:@"7"].location == NSNotFound)&&([fName rangeOfString:@"8"].location == NSNotFound)&&([fName rangeOfString:@"9"].location == NSNotFound))
    {
        
        // Level two for Last Name
        
        if (([lName length]!= 0)&&([lName rangeOfString:@" "].location == NSNotFound)&&([lName rangeOfString:@"0"].location == NSNotFound)&&([lName rangeOfString:@"1"].location == NSNotFound)&&([lName rangeOfString:@"2"].location == NSNotFound)&&([fName rangeOfString:@"3"].location == NSNotFound)&&([lName rangeOfString:@"4"].location == NSNotFound)&&([lName rangeOfString:@"5"].location == NSNotFound)&&([lName rangeOfString:@"6"].location == NSNotFound)&&([lName rangeOfString:@"7"].location == NSNotFound)&&([lName rangeOfString:@"8"].location == NSNotFound)&&([lName rangeOfString:@"9"].location == NSNotFound))
        {
            // Level three for Email
            
            if (([emailForSignUp rangeOfString:@" "].location == NSNotFound)&&([emailForSignUp rangeOfString:@"@"].location != NSNotFound)&&([emailForSignUp rangeOfString:@"."].location != NSNotFound)) {
                
                
                
                
                if ([password length]>=8) {
                    
                    if ([confirmPassword isEqualToString:password]) {
                        
                        
                        
                        NSString *activationCode = [self activationCodeGenerator];
                        NSString *messageBody = [@"Welcome to A-Cube. \n \n \n Thank you for signing up. Your activation code is: " stringByAppendingString:activationCode];
                        
                        
                        MCOSMTPSession *smtpSession = [[MCOSMTPSession alloc]init];
                        smtpSession.hostname = @"smtp.gmail.com";
                        smtpSession.port = 465;
                        smtpSession.username = @"teama3login@gmail.com";
                        smtpSession.password = @"teamA3FOSE";
                        smtpSession.authType = MCOAuthTypeSASLPlain;
                        smtpSession.connectionType = MCOConnectionTypeTLS;
                        
                        MCOMessageBuilder *builder = [[MCOMessageBuilder alloc] init];
                        MCOAddress *from = [MCOAddress addressWithDisplayName:@"A-Cube"
                                                                      mailbox:@"akshayadav@gmail.com"];
                        MCOAddress *to = [MCOAddress addressWithDisplayName:nil
                                                                    mailbox:emailForSignUp];
                        [[builder header] setFrom:from];
                        [[builder header] setTo:@[to]];
                        [[builder header] setSubject:@"Activation Code For A-Cube"];
                        [builder setHTMLBody:messageBody];
                        NSData * rfc822Data = [builder data];
                        
                        MCOSMTPSendOperation *sendOperation =
                        [smtpSession sendOperationWithData:rfc822Data];
                        [sendOperation start:^(NSError *error) {
                            if(error) {
                                NSLog(@"Error sending email: %@", error);
                            } else {
                                NSLog(@"Successfully sent email!");
                            }
                        }];
                        
                        
                        
                        
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Email Send Successfully"
                                                                       message: @"Please check your email id for activation code."
                                                                      delegate: self
                                                             cancelButtonTitle:@"OK"
                                                             otherButtonTitles:nil];
                        
                        [alert setTag:6];
                        [alert show];
                        
                        
                        NSString *encodedEmailId = [self encodeEmailId:emailForSignUp];
                        
                        NSDictionary *userDetails = @{@"firstName": fName,@"lastName": lName, @"activationCode": activationCode, @"passWord":encryptedData };
                                                      
                                                      
                                                      
                       Firebase *pendingActivation = [[Firebase alloc]initWithUrl:@"https://acube.firebaseio.com/pendingactivation" ];
                        
                        
                        Firebase *thisParticularPendingActivation = [pendingActivation childByAppendingPath:encodedEmailId];
                        
                        [thisParticularPendingActivation setValue:userDetails];
                        
                        
                        
                        
                        [self performSegueWithIdentifier:@"signupToActivation" sender:self];
                        
                        
                        
                        
                        
                        
                    }
                    
                    else{
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Password Mismatch"
                                                                       message: @"Please check the password confirmation"
                                                                      delegate: self
                                                             cancelButtonTitle:@"OK"
                                                             otherButtonTitles:nil];
                        
                        [alert setTag:5];
                        [alert show];
                    }
                    
                    
                }
                
                else{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Password"
                                                                   message: @"Password should be ateast 8 characters long."
                                                                  delegate: self
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
                    
                    [alert setTag:4];
                    [alert show];
                    
                }
                
            }
            
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Email Address"
                                                               message: @"Please add a valid Email Address"
                                                              delegate: self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
                
                [alert setTag:3];
                [alert show];
            }
            
            
            
            // Level three ends here
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Last Name"
                                                           message: @"Please add a valid Last Name"
                                                          delegate: self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
            
            [alert setTag:2];
            [alert show];
        }
        // Level two ends here! 
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid First Name"
                                                       message: @"Please add a valid First Name"
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert setTag:1];
        [alert show];
    }
    
}
@end
