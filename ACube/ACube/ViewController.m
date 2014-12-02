//
//  ViewController.m
//  ACube
//
//  Created by Akshay Yadav on 10/28/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "ViewController.h"
#import <MailCore/MailCore.h>
#import <Firebase/Firebase.h>
#import "AESCrypt.h"


@implementation ViewController


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


- (void)viewDidLoad
{
    
    

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginButtonAction:(id)sender {
    
    
    enteredEmailId = [self encodeEmailId:self.enteredEmailTextBox.text];
    enteredPassword = self.enteredPAsswordTextBox.text;
    
    NSString *encryptionKey = @"abcdefghijkl";
    
    NSString *encryptedData = [AESCrypt encrypt:enteredPassword password:encryptionKey];
    NSLog(@"encryptedString: %@", encryptedData);
    
    NSString *decryptedString = [AESCrypt decrypt:encryptedData password:encryptionKey];
    NSLog(@"decryptedString: %@", decryptedString);
    
    //checking for admin
   
    
    NSString *AdminURL = @"https://acube.firebaseio.com/AdministratorAccount";
    
    Firebase *AdministratorFireBase = [[Firebase alloc]initWithUrl:AdminURL ];
    
    
    [AdministratorFireBase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *adminEmail){
    
        if ([adminEmail.value[@"email"] isEqualToString: enteredEmailId]) {
            
            NSLog(@"correct email");
            
            if ([adminEmail.value[@"password"] isEqualToString:encryptedData]) {
                NSLog(@"Admin Logged In");
               [self performSegueWithIdentifier:@"adminloggedin" sender:self];
                
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Admin Password"
                                                               message: @"Please check the Password"
                                                              delegate: self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
                
                [alert setTag:8];
                [alert show];

            }
        }
    
        else{
            
            NSString *desiredURL = [@"https://acube.firebaseio.com/ActiveUsers/" stringByAppendingString:enteredEmailId ];
            
            Firebase *enteredFireBase = [[Firebase alloc]initWithUrl:desiredURL ];
            
            
            [enteredFireBase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
                
                if (snapshot.value == [NSNull null]) {
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Email entry"
                                                                   message: @"Please check the email Id"
                                                                  delegate: self
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
                    
                    [alert setTag:9];
                    [alert show];
                    
                    
                    
                    
                }
                
                else{
                    
                    
                    
                    if ([snapshot.value[@"passWord"] isEqualToString:encryptedData]) {
                        
                        
                        [[NSUserDefaults standardUserDefaults]setValue:[@"https://acube.firebaseio.com/ActiveUsers/" stringByAppendingString:enteredEmailId ] forKey:@"loggedInUserdetailsURL"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                        NSLog(@"Path %@",path);
                        
                        
                        if ([snapshot.value[@"role"] isEqualToString:@"student"]) {
                            [self performSegueWithIdentifier:@"loginFromHome" sender:self];
                        }
                        else{
                            [self performSegueWithIdentifier:@"signingInasContentManager" sender:self];
                        }
                        
                    }
                    else{
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Password"
                                                                       message: @"Please check the Password"
                                                                      delegate: self
                                                             cancelButtonTitle:@"OK"
                                                             otherButtonTitles:nil];
                        
                        [alert setTag:8];
                        [alert show];
                    }
                    
                    
                }
                
                
                
            }];
        }
    
    }];
    
    
}
@end
