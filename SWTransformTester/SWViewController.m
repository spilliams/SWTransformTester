//
//  SWViewController.m
//  SWTransformTester
//
//  Created by Spencer Williams on 2/13/13.
//  Copyright (c) 2013 Spencer Williams. All rights reserved.
//

#import "SWViewController.h"

@interface SWViewController ()
- (void)updateTransformLabels;
- (void)updateFrameLabels;
- (void)registerObserversForTransformView;
- (void)unregisterObserversForTransformView;
@end

@implementation SWViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self updateTransformLabels];
    [self updateFrameLabels];
    [self registerObserversForTransformView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setALabel:nil];
    [self setBLabel:nil];
    [self setCLabel:nil];
    [self setDLabel:nil];
    [self setTxLabel:nil];
    [self setTyLabel:nil];
    
    [self setXLabel:nil];
    [self setYLabel:nil];
    [self setWLabel:nil];
    [self setHLabel:nil];
    
    [self setTranslateTxField:nil];
    [self setTranslateTyField:nil];
    [self setScaleSxField:nil];
    [self setScaleSyField:nil];
    [self setRotateAngleField:nil];
    [self setConcatTransformField:nil];
    
    [self setTransformView:nil];
    
    [super viewDidUnload];
}

#pragma mark - Private Helpers

- (void)updateTransformLabels
{
    [self.aLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.a]];
    [self.bLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.b]];
    [self.cLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.c]];
    [self.dLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.d]];
    [self.txLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.tx]];
    [self.tyLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.transform.ty]];
}

- (void)updateFrameLabels
{
    [self.xLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.frame.origin.x]];
    [self.yLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.frame.origin.y]];
    [self.wLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.frame.size.width]];
    [self.hLabel setText:[NSString stringWithFormat:@"%.2f",self.transformView.frame.size.height]];
}

- (void)registerObserversForTransformView
{
    [self.transformView addObserver:self
                         forKeyPath:@"transform"
                            options:NSKeyValueObservingOptionNew
                            context:nil];
    [self.transformView addObserver:self
                         forKeyPath:@"frame"
                            options:NSKeyValueObservingOptionNew
                            context:nil];
}

- (void)unregisterObserversForTransformView
{
    [self.transformView removeObserver:self forKeyPath:@"frame"];
    [self.transformView removeObserver:self forKeyPath:@"transform"];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"transform"]) {
        [self updateTransformLabels];
    } else if ([keyPath isEqualToString:@"frame"]) {
        [self updateFrameLabels];
    }
}

#pragma mark - IBActions

- (IBAction)textFieldDidEndOnExit:(id)sender {
    [(UITextField *)sender resignFirstResponder];
}

- (IBAction)identityButtonPressed:(id)sender {
    [self.transformView setTransform:CGAffineTransformIdentity];
}

- (IBAction)invertButtonPressed:(id)sender {
    [self.transformView setTransform:CGAffineTransformInvert(self.transformView.transform)];
}

- (IBAction)resetButtonPressed:(id)sender {
    [self unregisterObserversForTransformView];
    NSUInteger index = [[self.view subviews] indexOfObject:self.transformView];
    [self.transformView removeFromSuperview];
    [self setTransformView:[[UIView alloc] initWithFrame:CGRectMake(110, 52, 100, 100)]];
    [self.transformView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view insertSubview:self.transformView atIndex:index];
    [self registerObserversForTransformView];
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

@end
