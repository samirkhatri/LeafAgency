//
//  ActivityIndicator.m
//  TwitterAndFacebook
//
//  Created by Samir Kha on 16/06/2012.
//  Copyright (c) 2012 __Jaha Rabari__. All rights reserved.
//

#import "ActivityIndicator.h"
#import <QuartzCore/QuartzCore.h>


#define degreesToRadians(x) (M_PI * x / 180.0)
@implementation ActivityIndicator
@synthesize centerMessageLabel, subMessageLabel;
@synthesize spinner;
@synthesize image_spinner = _image_spinner;

static ActivityIndicator *currentIndicator = nil;


+ (ActivityIndicator *)currentIndicator
{
	if (currentIndicator == nil)
	{
		//UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
		CGRect keyWindow = [[UIScreen mainScreen] bounds];
	//	CGFloat width = 160;
	//	CGFloat height = 120;
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        
		CGRect centeredFrame = CGRectMake(round(keyWindow.size.width/2 - width/2),
										  round(keyWindow.size.height/2 - height/2),
										  width,
										  height);
        
		
		currentIndicator = [[ActivityIndicator alloc] initWithFrame:centeredFrame];
		
		currentIndicator.backgroundColor = [UIColor colorWithRed:99.0/255.0 green:173.0/255.0 blue:198.0/255.0 alpha:0.9];
		currentIndicator.opaque = NO;
		currentIndicator.alpha = 0;
		
		currentIndicator.layer.cornerRadius = 10;
		
		currentIndicator.userInteractionEnabled = NO;
		currentIndicator.autoresizesSubviews = YES;
		currentIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |  UIViewAutoresizingFlexibleTopMargin |  UIViewAutoresizingFlexibleBottomMargin;
		
		//[currentIndicator setProperRotation:NO];
       // currentIndicator.transform = CGAffineTransformRotate(CGAffineTransformIdentity, degreesToRadians(-90));
		
//		[[NSNotificationCenter defaultCenter] addObserver:currentIndicator
//												 selector:@selector(setProperRotation)
//													 name:UIDeviceOrientationDidChangeNotification
//												   object:nil];
	}
	
	return currentIndicator;
}

#pragma mark Creating Message

- (void)show
{	

	if ([self superview] != [[UIApplication sharedApplication] keyWindow]) 
		[[[UIApplication sharedApplication] keyWindow] addSubview:self];
	
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	
	self.alpha = 1;
	
	[UIView commitAnimations];
}

- (void)hideAfterDelay
{
	[self performSelector:@selector(hide) withObject:nil afterDelay:2.0];
  }

- (void)hide
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(hidden)];
	
	self.alpha = 0;
	
	[UIView commitAnimations];
}

- (BOOL)ishidden {
    if (currentIndicator.superview == nil) {
        return YES;
    }
    return NO;
}

- (void)persist
{	
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.1];
	
	self.alpha = 1;
	
	[UIView commitAnimations];
}

- (void)hidden
{
	if (currentIndicator.alpha > 0)
		return;
	
	[currentIndicator removeFromSuperview];
	currentIndicator = nil;
}

- (void)displayActivity:(NSString *)m
{
    if(![[AppDelegate appDelegate] isReachable]){
        return;
    }
	[self setSubMessage:m];
	[self showSpinner];
    [_image_spinner removeFromSuperview];
	
	[centerMessageLabel removeFromSuperview];
	centerMessageLabel = nil;
	
	if ([self superview] == nil)
		[self show];
	else
		[self persist];

}

- (void)displayCompleted:(NSString *)m
{	
	[self setCenterMessage:@""];
	[self setSubMessage:m];
	
	[spinner removeFromSuperview];
    [self displayImageAfterCompleted];
	spinner = nil;
	
	if ([self superview] == nil)
		[self show];
	else
		[self persist];
    
	[self hideAfterDelay];
    
    
}
- (void)displayCompleted
{
    if ([self ishidden]) {
        return;
    }
	//[self setCenterMessage:@"✓"];
	[self setCenterMessage:@""];
    [self setSubMessage:@"Success!"];
    [spinner removeFromSuperview];
    [self displayImageAfterCompleted];
	spinner = nil;
	
	if ([self superview] == nil)
		[self show];
	else
		[self persist];
    
	[self hideAfterDelay];
}

-(void)displayImageAfterCompleted{
    _image_spinner = [[UIImageView alloc] initWithFrame:CGRectMake(round(self.bounds.size.width/2 - spinner.frame.size.width/2-75+15),
                                                                   round(self.bounds.size.height/2 - spinner.frame.size.height/2-75),
                                                                   150,
                                                                   150)];
    _image_spinner.backgroundColor = [UIColor clearColor];
    _image_spinner.opaque = NO;
    [_image_spinner setImage:[UIImage imageNamed:@"correct_new.png"]];
    [self addSubview:_image_spinner];
}

- (void)displayCompletedWithError:(NSString *)m
{	
	[self setCenterMessage:@"X"];
	[self setSubMessage:m];
	
	[spinner removeFromSuperview];
	spinner = nil;
	
	if ([self superview] == nil)
		[self show];
	else
		[self persist];
    
	[self hideAfterDelay];
}

- (void)setCenterMessage:(NSString *)message
{	
	if (message == nil && centerMessageLabel != nil)
		self.centerMessageLabel = nil;
    
	else if (message != nil)
	{
		if (centerMessageLabel == nil)
		{
			self.centerMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,round(self.bounds.size.height/2-50/2),self.bounds.size.width-24,50)];
			centerMessageLabel.backgroundColor = [UIColor clearColor];
			centerMessageLabel.opaque = NO;
			centerMessageLabel.textColor = [UIColor whiteColor];
			centerMessageLabel.font = [UIFont boldSystemFontOfSize:40];
			centerMessageLabel.textAlignment = NSTextAlignmentCenter;
			centerMessageLabel.shadowColor = [UIColor darkGrayColor];
			centerMessageLabel.shadowOffset = CGSizeMake(1,1);
			centerMessageLabel.adjustsFontSizeToFitWidth = YES;
			
			[self addSubview:centerMessageLabel];
		}
		
		centerMessageLabel.text = message;
	}
}

- (void)setSubMessage:(NSString *)message
{	
	if (message == nil && subMessageLabel != nil)
		self.subMessageLabel = nil;
	
	else if (message != nil)
	{
		if (subMessageLabel == nil)
		{
			self.subMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,self.bounds.size.height/2+70,self.bounds.size.width-24,30)];
			subMessageLabel.backgroundColor = [UIColor clearColor];
			subMessageLabel.opaque = NO;
			subMessageLabel.textColor = [UIColor whiteColor];
			subMessageLabel.font = [UIFont boldSystemFontOfSize:17];
			subMessageLabel.textAlignment = NSTextAlignmentCenter;
			subMessageLabel.shadowColor = [UIColor darkGrayColor];
			subMessageLabel.shadowOffset = CGSizeMake(1,1);
			subMessageLabel.adjustsFontSizeToFitWidth = YES;
			
			[self addSubview:subMessageLabel];
		}
		
		subMessageLabel.text = message;
	}
}

- (void)showSpinner
{	
	if (spinner == nil)
	{
		self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
		spinner.frame = CGRectMake(round(self.bounds.size.width/2 - spinner.frame.size.width/2),
                                   round(self.bounds.size.height/2 - spinner.frame.size.height/2),
                                   spinner.frame.size.width,
                                   spinner.frame.size.height);		
	
	}
	
	[self addSubview:spinner];
	[spinner startAnimating];
}

#pragma mark -
#pragma mark Rotation

- (void)setProperRotation
{
	[self setProperRotation:YES];
}

- (void)setProperRotation:(BOOL)animated
{
	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	
	if (animated)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
	}
	
	if (orientation == UIDeviceOrientationPortraitUpsideDown)
		self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, degreesToRadians(180));	
	
	else if (orientation == UIDeviceOrientationLandscapeLeft)
		self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, degreesToRadians(90));	
	
	else if (orientation == UIDeviceOrientationLandscapeRight)
		self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, degreesToRadians(-90));
	
	if (animated)
		[UIView commitAnimations];
}


@end
