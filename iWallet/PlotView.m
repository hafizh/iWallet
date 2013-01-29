//
//  PlotView.m
//  iWallet
//
//  Created by lab on 1/29/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "PlotView.h"

@implementation PlotView

int paddingH = 3;
int paddingV = 3;
int plotWidth = 320;
int plotHeight;

CGColorRef CreateDeviceGrayColor(CGFloat w, CGFloat a)
{
	CGColorSpaceRef gray = CGColorSpaceCreateDeviceGray();
	CGFloat comps[] = {w, a};
	CGColorRef color = CGColorCreate(gray, comps);
	CGColorSpaceRelease(gray);
	return color;
}

CGColorRef graphBackgroundColor()
{
	static CGColorRef c = NULL;
	if(c == NULL)
	{
		c = CreateDeviceGrayColor(0.6, 1.0);
	}
	return c;
}

CGColorRef graphLineColor()
{
	static CGColorRef c = NULL;
	if(c == NULL)
	{
		c = CreateDeviceGrayColor(0.4, 1.0);
	}
	return c;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    // Initialization code
    self.backgroundColor = [UIColor colorWithCGColor: graphBackgroundColor()];
    
    plotWidth = self.frame.size.width-paddingV;
    plotHeight = self.frame.size.height-paddingH;
    
    return self;
}



- (void)drawLineInContext:(CGContextRef)context originX:(float)x1 originY:(float)y1 destX:(float)x2 destY:(float)y2 width:(float)width
{
//    CGContextBeginPath(context);
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, nil, x1, y1);
//    CGPathAddLineToPoint(path, nil, x2, y2);
//    CGContextAddPath(context, path);
//    CGContextSetLineWidth(context, width);
//    CGContextDrawPath(context, kCGPathFillStroke);
//    CGPathRelease(path);
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
	CGContextMoveToPoint(context, paddingV, 0);
	CGContextAddLineToPoint(context, paddingV, plotHeight);
	CGContextStrokePath(context);
	
    NSLog(@"plotHeight:%d", plotHeight);
    for (int i = 10; i < 200; i+= 10) {
		CGContextSetStrokeColorWithColor(context, graphLineColor());
		
		CGContextMoveToPoint(context, 0, i);
		CGContextAddLineToPoint(context, plotWidth, i);
		CGContextStrokePath(context);
	}
    
}

@end
