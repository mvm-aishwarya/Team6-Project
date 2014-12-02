//
//  activationVC.h
//  ACube
//
//  Created by Akshay Yadav on 10/30/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface activationVC : UIViewController{
    
    NSString *emailIDEnteredString;
    NSString *activationCodeString;
    
    NSString *activatingURLtoDelete;
    
    NSString *newActiveURL;
    
}



@property (weak, nonatomic) IBOutlet UITextField *emailIDEntered;

@property (weak, nonatomic) IBOutlet UITextField *activationCodeEntered;

@property (weak, nonatomic) IBOutlet UIButton *activationButton;




- (IBAction)activationAction:(id)sender;


@end
