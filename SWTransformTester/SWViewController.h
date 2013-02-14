//
//  SWViewController.h
//  SWTransformTester
//
//  Created by Spencer Williams on 2/13/13.
//  Copyright (c) 2013 Spencer Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *aLabel;
@property (strong, nonatomic) IBOutlet UILabel *bLabel;
@property (strong, nonatomic) IBOutlet UILabel *cLabel;
@property (strong, nonatomic) IBOutlet UILabel *dLabel;
@property (strong, nonatomic) IBOutlet UILabel *txLabel;
@property (strong, nonatomic) IBOutlet UILabel *tyLabel;

@property (strong, nonatomic) IBOutlet UILabel *xLabel;
@property (strong, nonatomic) IBOutlet UILabel *yLabel;
@property (strong, nonatomic) IBOutlet UILabel *wLabel;
@property (strong, nonatomic) IBOutlet UILabel *hLabel;

@property (strong, nonatomic) IBOutlet UITextField *translateTxField;
@property (strong, nonatomic) IBOutlet UITextField *translateTyField;
@property (strong, nonatomic) IBOutlet UITextField *scaleSxField;
@property (strong, nonatomic) IBOutlet UITextField *scaleSyField;
@property (strong, nonatomic) IBOutlet UITextField *rotateAngleField;
@property (strong, nonatomic) IBOutlet UITextField *concatTransformField;

- (IBAction)textFieldDidEndOnExit:(id)sender;

- (IBAction)identityButtonPressed:(id)sender;
- (IBAction)invertButtonPressed:(id)sender;
- (IBAction)translateButtonPressed:(id)sender;
- (IBAction)scaleButtonPressed:(id)sender;
- (IBAction)rotateButtonPressed:(id)sender;
- (IBAction)concatButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *transformView;
@end
