//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Ricky Pattillo on 12/14/14.
//  Copyright (c) 2014 Ricky Pattillo. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView


- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self ) {
      self.backgroundColor = [UIColor clearColor];
   }
   
   return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
   CGRect bounds = self.bounds;
   CGPoint center;
   center.x = bounds.origin.x + bounds.size.width / 2.0;
   center.y = bounds.origin.y + bounds.size.height / 2.0;
   
   // Draw concentric circles
   float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
   
   [[UIColor lightGrayColor] setStroke];
   
   UIBezierPath *path = [[UIBezierPath alloc] init];
   for ( float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20 ) {
      [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
      [path addArcWithCenter:center
                      radius:currentRadius
                  startAngle:0
                    endAngle:M_PI * 2.0
                   clockwise:YES];
   }

   path.lineWidth = 10;
   [path stroke];

   CGContextRef currentContext = UIGraphicsGetCurrentContext();

   // Draw Gradient
   CGContextSaveGState(currentContext);
   UIBezierPath *clippingMask = [[UIBezierPath alloc] init];
   [clippingMask moveToPoint:CGPointMake(bounds.size.width / 2.0, bounds.size.height / 8.0)];
   [clippingMask addLineToPoint:CGPointMake(bounds.size.width * 4.0 / 5.0, bounds.size.height * 7.0 / 8.0)];
   [clippingMask addLineToPoint:CGPointMake(bounds.size.width / 5.0, bounds.size.height * 7.0 / 8.0)];
   [clippingMask closePath];
   [clippingMask addClip];
   
   CGFloat locations[2] = {0.0, 1.0};
   CGFloat components[8] = {1.0, 0.0, 0.0, 1.0,
      1.0, 1.0, 0.0, 1.0};
   CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
   CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
   CGPoint top = CGPointMake(bounds.size.width / 2.0, bounds.size.height / 8.0);
   CGPoint bottom = CGPointMake(bounds.size.width / 2.0, bounds.size.height * 7.0 / 8.0);
   CGContextDrawLinearGradient(currentContext, gradient, top, bottom, 0);
   
   CGContextRestoreGState(currentContext);
   
   CGColorSpaceRelease(colorspace);
   CGGradientRelease(gradient);
   
   // Draw BNR logo
   CGContextSaveGState(currentContext);
   CGContextSetShadow(currentContext, CGSizeMake(4.0, 8.0), 3);
   
   UIImage *logoImage = [UIImage imageNamed:@"logo"];
   float screenRatio = 0.7;
   CGSize logoSize = CGSizeMake(bounds.size.width * screenRatio, bounds.size.height * screenRatio);
   CGPoint logoOrigin = CGPointMake((bounds.size.width - logoSize.width) / 2.0,
                                    (bounds.size.height - logoSize.height) / 2.0);
   
   CGRect logoRect = CGRectMake(logoOrigin.x, logoOrigin.y, logoSize.width, logoSize.height);
   [logoImage drawInRect:logoRect];
   
   CGContextRestoreGState(currentContext);
}


@end
