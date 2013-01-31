//
//  PlotView.m
//  iWallet
//
//  Created by lab on 1/29/13.
//  Copyright (c) 2013 lab. All rights reserved.
//

#import "PlotView.h"

@implementation PlotView

int paddingH = 10;
int paddingV = 10;
int plotWidth = 320;
int plotHeight;
NSMutableArray *dummyData;

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
    
    // ******** INIT DUMMY DATA *****************//
    
    dummyData = [[NSMutableArray alloc]init];
    
    for(int i = 0; i <=30; i++){
        [dummyData addObject:[NSString stringWithFormat:@"%d€", arc4random_uniform(150)]];
    }
    // ********* FINISH DUMMY ******************//
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw y axis
    CGContextBeginPath(context);
	CGContextMoveToPoint(context, paddingV, paddingH);
	CGContextAddLineToPoint(context, paddingV, plotHeight - paddingH);
	CGContextStrokePath(context);
    
    // draw gridlines
    NSLog(@"plotHeight:%d", plotHeight);
    for (int i = 10; i < plotHeight; i+= 10) {
		CGContextSetStrokeColorWithColor(context, graphLineColor());
		
		CGContextMoveToPoint(context, paddingV, i);
		CGContextAddLineToPoint(context, plotWidth, i);
		CGContextStrokePath(context);
        
        int reverseIndex = (i/10);
        [[NSString stringWithFormat:@"%i", reverseIndex] drawInRect:
                 CGRectMake(2, (plotHeight-paddingH) - reverseIndex*10, paddingV, paddingH)
                                                     withFont:[UIFont systemFontOfSize:paddingH - 3]
                                                lineBreakMode:NSLineBreakByWordWrapping
                                                    alignment:NSTextAlignmentLeft];
        
	}
    
    // draw x axis
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, paddingV, plotHeight - paddingH);
    CGContextAddLineToPoint(context, plotWidth, plotHeight - paddingH);
    CGContextStrokePath(context);

    
}


- (void)drawData:(CGContextRef) context
{
    CGContextSetStrokeColorWithColor(context, CreateDeviceGrayColor(0.9, 1.0));
    for (NSString *str in dummyData) {
        float xValue = [str floatValue];
        
        [self drawLineInContext:context
                        originX:paddingV
                        originY:plotHeight-paddingH
                          destX:paddingV
                          destY:(plotHeight-paddingH) - xValue
                          width:4];
    }
    
}

- (void)drawLineInContext:(CGContextRef)context originX:(float)x1 originY:(float)y1 destX:(float)x2 destY:(float)y2 width:(float)width
{
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, x1, y1);
        CGContextAddLineToPoint(context, x2, y2);
        CGContextSetLineWidth(context, width);
    CGContextStrokePath(context);
}


@end
