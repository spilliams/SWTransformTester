//
//  SWViewController.m
//  SWTransformTester
//
//  Created by Spencer Williams on 2/13/13.
//  Copyright (c) 2013 Spencer Williams. All rights reserved.
//

#import "SWViewController.h"

@interface SWViewController ()
- (void)updateLabels;
@end

@implementation SWViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self updateLabels];
    [self.transformView addObserver:self
                         forKeyPath:@"transform"
                            options:NSKeyValueObservingOptionNew
                            context:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [self updateLabels];
}

#pragma mark - Private Helpers

- (void)updateLabels
{
    [self.aLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.a]];
    [self.bLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.b]];
    [self.cLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.c]];
    [self.dLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.d]];
    [self.txLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.tx]];
    [self.tyLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.ty]];
}

#pragma mark - IBActions

- (IBAction)textFieldDidEndOnExit:(id)sender {
    [(UITextField *)sender resignFirstResponder];
}

- (IBAction)resetButtonPressed:(id)sender {
    [self.transformView setTransform:CGAffineTransformIdentity];
}

- (IBAction)invertButtonPressed:(id)sender {
    [self.transformView setTransform:CGAffineTransformInvert(self.transformView.transform)];
}

- (IBAction)translateButtonPressed:(id)sender {
    [self.translateTxField resignFirstResponder];
    [self.translateTyField resignFirstResponder];
    @try {
        [self.transformView setTransform:CGAffineTransformTranslate(self.transformView.transform,
                                                                    self.translateTxField.text.floatValue,
                                                                    self.translateTyField.text.floatValue)];
    }
    @catch (NSException *exception) {
        
    }
}

- (IBAction)scaleButtonPressed:(id)sender {
    [self.scaleSxField resignFirstResponder];
    [self.scaleSyField resignFirstResponder];
    @try {
        [self.transformView setTransform:CGAffineTransformScale(self.transformView.transform,
                                                                self.scaleSxField.text.floatValue,
                                                                self.scaleSyField.text.floatValue)];
    }
    @catch (NSException *exception) {
        
    }
}

- (IBAction)rotateButtonPressed:(id)sender {
    [self.rotateAngleField resignFirstResponder];
    @try {
        [self.transformView setTransform:CGAffineTransformRotate(self.transformView.transform,
                                                                 self.rotateAngleField.text.floatValue * M_PI/180.)];
    }
    @catch (NSException *exception) {
        
    }
}

- (IBAction)concatButtonPressed:(id)sender {
    [self.concatTransformField resignFirstResponder];
    @try {
        [self.transformView setTransform:CGAffineTransformConcat(self.transformView.transform,
                                                                 CGAffineTransformFromString(self.concatTransformField.text))];
    }
    @catch (NSException *exception) {
        
    }
}

- (IBAction)logButtonPressed:(id)sender {
    [self updateLabels];
}
@end
