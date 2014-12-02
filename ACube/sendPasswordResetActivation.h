//
//  sendPasswordResetActivation.h
//  ACube
//
//  Created by Akshay Yadav on 11/30/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Firebase/Firebase.h>
#import <Foundation/Foundation.h>


@interface sendPasswordResetActivation : UIViewController{
    NSString *emailIdForPasswordReset;
    }

@property (weak, nonatomic) IBOutlet UITextField *emailID;
- (IBAction)SendActivationAction:(id)sender;



@end
