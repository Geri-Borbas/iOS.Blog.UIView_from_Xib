//
//  EPPZViewController.m
//  UIView_from_Xib
//
//  Created by Borbás Geri on 2/25/14.
//  Copyright (c) 2014 eppz! development, LLC.
//
//  follow http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "EPPZViewController.h"
#import "EPPZSubclassedView.h"
#import "EPPZDecoupledView.h"


@interface EPPZViewController () <EPPZDecoupledViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *referencedView;
-(IBAction)showPlainView;
-(IBAction)showReferencedView;
-(IBAction)showConnectedActionsView;
-(IBAction)connectedActionsViewTouchedUp:(UIButton*) button;
-(IBAction)showSubclassedView;
-(IBAction)showDecoupledView;

@end


@implementation EPPZViewController


#pragma mark - The plain way (the poor man’s method to load UIView from XIB)

-(IBAction)showPlainView
{
    // Instantiate the nib content without any reference to it.
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"EPPZPlainView" owner:nil options:nil];
    
    // Find the view among nib contents (not too hard assuming there is only one view in it).
    UIView *plainView = [nibContents lastObject];
    
    // Some hardcoded layout.
    CGSize padding = (CGSize){ 22.0, 22.0 };
    plainView.frame = (CGRect){padding.width, padding.height, plainView.frame.size};
    
    // Add to the view hierarchy (thus retain).
    [self.view addSubview:plainView];
}


#pragma mark - The referenced way (a bit more explicit)

-(IBAction)showReferencedView
{
    // Instantiate a referenced view (assuming outlet has hooked up in XIB).
    [[NSBundle mainBundle] loadNibNamed:@"EPPZReferencedView" owner:self options:nil];
    
    // Controller's outlet has been bound during nib loading, so we can access view trough the outlet.
    [self.view addSubview:self.referencedView];
}


#pragma mark - Connected actions (some addition for the above actually)

-(IBAction)showConnectedActionsView
{
    // Instantiate a referenced view (assuming outlet has hooked up in XIB).
    [[NSBundle mainBundle] loadNibNamed:@"EPPZConnectedActionsView" owner:self options:nil];
    
    // Controller's outlet has been bound during nib loading, so we can access view trough the outlet.
    [self.view addSubview:self.referencedView];
}

-(IBAction)connectedActionsViewTouchedUp:(UIButton*) button
{
    // Any interaction (I simply remove the custom view here).
    [button.superview removeFromSuperview];
}


#pragma mark - Encapsulated instantiation (a step toward enlighting controller code)

-(IBAction)showSubclassedView
{
    // A tiny one-liner that has anything to do with the custom view.
    [EPPZSubclassedView presentInViewController:self];
}


#pragma mark - Encapsulate everything (a really flexible, reusable way to load your custom UIView from XIB)

-(IBAction)showDecoupledView
{ [EPPZDecoupledView presentInViewController:self]; }

-(void)decoupledViewTouchedUp:(EPPZDecoupledView*) decoupledView
{ /* Whatever feature. */ }

-(void)decoupledViewDidDismiss:(EPPZDecoupledView*) decoupledView
{ /* Acknowledge sadly. */ }


@end
