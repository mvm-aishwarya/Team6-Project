//
//  sendPasswordResetActivation.m
//  ACube
//
//  Created by Akshay Yadav on 11/30/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import "sendPasswordResetActivation.h"
#import <MailCore/MailCore.h>
#import <Firebase/Firebase.h>

#import "AESCrypt.h"



@implementation sendPasswordResetActivation



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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




- (IBAction)SendActivationAction:(id)sender {
    
    emailIdForPasswordReset = self.emailID.text;
    
    if (([emailIdForPasswordReset rangeOfString:@" "].location == NSNotFound)&&([emailIdForPasswordReset rangeOfString:@"@"].location != NSNotFound)&&([emailIdForPasswordReset rangeOfString:@"."].location != NSNotFound)) {
        
        NSString *emailIdForPasswordResetEncrypted = [self encodeEmailId:emailIdForPasswordReset];
    
        Firebase *thisEmailIDUsersDetails = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/ActiveUsers/" stringByAppendingString:[emailIdForPasswordResetEncrypted stringByAppendingString:@"/passwordResetActivation" ] ] ];
        
        
        
         Firebase *thisEmailIDUsersexists = [[Firebase alloc]initWithUrl:[@"https://acube.firebaseio.com/ActiveUsers/" stringByAppendingString:[emailIdForPasswordResetEncrypted stringByAppendingString:@"/passWord" ] ] ];
        
    
        [thisEmailIDUsersexists observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
            
            if (snapshot.value == [NSNull null]) { UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Invalid Email"
                                                                                                  message: @"This email is not registered."
                                                                                                 delegate: self
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                
                [alert setTag:26];
                [alert show];}
        
        
        else {
            
            
            
            
            
            NSString *activationCode = [self activationCodeGenerator];
            NSString *messageBody = [@"Welcome to A-Cube. \n \n \n Thank you for signing up. Your Password Reset activation code is: " stringByAppendingString:activationCode];
            
            
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
                                                        mailbox:emailIdForPasswordReset];
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
            
            
            
            
            
            
            
            [thisEmailIDUsersDetails setValue:activationCode];
            
            
            
            
            
        }}];
        
        
        
    
    
    
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
