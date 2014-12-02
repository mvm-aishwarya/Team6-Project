//
//  ViewController.h
//  ACube
//
//  Created by Akshay Yadav on 10/28/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import <Foundation/Foundation.h>

@interface ViewController : UIViewController{
    
    NSString *enteredEmailId;
    NSString *enteredPassword;
    
    
}
@property (weak, nonatomic) IBOutlet UITextField *enteredEmailTextBox;
@property (weak, nonatomic) IBOutlet UITextField *enteredPAsswordTextBox;

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

- (IBAction)LoginButtonAction:(id)sender;

@end
