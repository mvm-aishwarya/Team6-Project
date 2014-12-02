//
//  courseContents.h
//  ACube
//
//  Created by Akshay Yadav on 11/16/14.
//  Copyright (c) 2014 Akshay Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface courseContents : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *videoURL;

@property (weak, nonatomic) IBOutlet UITextField *pdfURL;

@property (weak, nonatomic) IBOutlet UILabel *videoAddedNotfication;

@property (weak, nonatomic) IBOutlet UILabel *PDFaddedNotification;

- (IBAction)uploadPdfAction:(id)sender;

- (IBAction)uploadVideoAction:(id)sender;

@end
