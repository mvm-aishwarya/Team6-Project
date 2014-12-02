//
//  activationVC.m
//  ACube
//
//  Created by Akshay Yadav on 10/30/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "activationVC.h"
#import <MailCore/MailCore.h>
#import "signUpVC.h"

@implementation activationVC


-(void)viewDidLoad{
    [super viewDidLoad];
    
   
    self.emailIDEntered.delegate = self;
    
    self.activationCodeEntered.delegate = self;
    
   activatingURLtoDelete = @"activationFail";
    newActiveURL = @"placeHolder";
    
   
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

- (IBAction)activationAction:(id)sender {
  


    emailIDEnteredString = self.emailIDEntered.text;
    activationCodeString = self.activationCodeEntered.text;
    
    NSString * encodedEmailID = [self encodeEmailId:emailIDEnteredString];
    
   
    
   
    Firebase *pendingActivation = [[Firebase alloc]initWithUrl:[[[@"https://acube.firebaseio.com/pendingactivation/" stringByAppendingString:encodedEmailID]stringByAppendingString:@"/"]stringByAppendingString:@"activationCode"]];
    
    
    
    [pendingActivation observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
        
        if (snapshot.value == [NSNull null]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Email not found"
                                                           message: @"No pending activation for this email"
                                                          delegate: self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
            
            [alert setTag:7];
            [alert show];
            
        }
        
        else{
            
            
            
            
            if ([snapshot.value isEqualToString:activationCodeString]) {
                NSLog(@"Login successful");
                NSLog(@"%@",snapshot.value);
                
                
                Firebase *ActivatingThisUser = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/pendingactivation/" stringByAppendingString:encodedEmailID]];
                
                [ActivatingThisUser observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshotActivatingUser){
                
                    NSMutableDictionary *userDetails = snapshotActivatingUser.value;
                    
                    [userDetails setObject:@"student" forKey:@"role"];
                    
                    [userDetails removeObjectForKey:@"activationCode"];
                    
                    NSLog(@"%@", userDetails);
                    
                    newActiveURL = [@"https://acube.firebaseio.com/ActiveUsers/" stringByAppendingString:encodedEmailID ];
                
                    Firebase *createLogin = [[Firebase alloc]initWithUrl:newActiveURL];
                    
                    [createLogin setValue:userDetails];
                    
                    
                    activatingURLtoDelete = [@"https://acube.firebaseio.com/pendingactivation/" stringByAppendingString:encodedEmailID];
                    
                    
                }];
                
                
               
                
                //[ActivatingThisUser setValue:[NSNull null]]; //<--------------------------- delete activation
                
                
                
             //   NSDictionary *userDetails = @{@"firstName": fName,@"lastName": lName, @"activationCode": activationCode, @"passWord": password};
                
                
                
              //  Firebase *pendingActivation = [[Firebase alloc]initWithUrl:@"https://acube.firebaseio.com/pendingactivation" ];
                
                
            //    Firebase *thisParticularPendingActivation = [pendingActivation childByAppendingPath:encodedEmailId];
                
           //     [thisParticularPendingActivation setValue:userDetails];
             
                
            }
            
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid activation Code"
                                                               message: @"The activation code you entered is Invalid."
                                                              delegate: self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
                
                [alert setTag:8];
                [alert show];
            }
        }
        
        
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
        
    }];
    

    
    [self performSelector:@selector(printit) withObject:self afterDelay:2.0 ];
    

    
    
}


-(void)printit{
    NSLog(@"Now theres a delay");
    if ([activatingURLtoDelete isEqualToString:@"activationFail"]) {
        NSLog(@"something's wrong");
    }
    else{
        Firebase *deleteThisURL = [[Firebase alloc]initWithUrl:activatingURLtoDelete];
        
        
        [deleteThisURL removeValue];
        
        [[NSUserDefaults standardUserDefaults]setValue:newActiveURL forKey:@"loggedInUserdetailsURL"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"Path %@",path);
        
        [self performSegueWithIdentifier:@"sucessfulLogin" sender:self];
        
        
    }
}

@end
