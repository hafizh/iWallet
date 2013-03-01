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
int paddingV = 15;
int plotWidth = 320;
int plotHeight;
NSArray *plotSpendings;

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
		c = CreateDeviceGrayColor(0.0, 1.0);
	}
	return c;
}

CGColorRef graphLineColor()
{
	static CGColorRef c = NULL;
	if(c == NULL)
	{
		c = CreateDeviceGrayColor(0.8, 1.0);
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
    
    plotSpendings = [[NSArray alloc]init];
    [self updateData];
    // ********* FINISH DUMMY ******************//
    return self;
}

- (void) updateData
{
    plotSpendings = nil;

    // get Spendings for Current month; 
    //DataQueries *plotQueries = [[DataQueries alloc] init];
    //[plotQueries getSpendingsForCategory:self.plotCategory forMonth:[self.plotNaviStrategy getCurrent] withSortDescriptor:<#(NSSortDescriptor *)#>]
    // generate random data
//    for(int i = 0; i <=30; i++){
//        [plotSpendings addObject:[NSString stringWithFormat:@"%d€", arc4random_uniform(75)]];
//    }

    plotSpendings = [self.plotNaviStrategy classifyCurrentForCategory:self.plotCategory];
    
    // update view
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, graphLineColor());
    // draw y axis
    CGContextBeginPath(context);
	CGContextMoveToPoint(context, paddingV, paddingH);
	CGContextAddLineToPoint(context, paddingV, plotHeight - paddingH);
	CGContextStrokePath(context);
    
    // draw gridlines
    //NSLog(@"plotHeight:%d", plotHeight);
    for (int i = 10; i < plotHeight; i+= 10) {
		
		
		CGContextMoveToPoint(context, paddingV, i);
		CGContextAddLineToPoint(context, plotWidth, i);
		CGContextStrokePath(context);
        
        // draw y axis labels
        int reverseIndex = (i/10);
        if(reverseIndex < 16){
            [[NSString stringWithFormat:@"%i", reverseIndex*5] drawInRect:
                 CGRectMake(4, (plotHeight-paddingH) - reverseIndex*10, paddingV, paddingH)
                                                     withFont:[UIFont systemFontOfSize:paddingH - 4]
                                                lineBreakMode:NSLineBreakByWordWrapping
                                                    alignment:NSTextAlignmentLeft];
        }
        else{
            [@"€" drawInRect:
             CGRectMake(4, (plotHeight-paddingH) - reverseIndex*10, paddingV, paddingH)
                                                                 withFont:[UIFont systemFontOfSize:paddingH - 2]
                                                            lineBreakMode:NSLineBreakByWordWrapping
                                                                alignment:NSTextAlignmentLeft];
        }
	}
    
    // draw x axis
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, paddingV, plotHeight - paddingH);
    CGContextAddLineToPoint(context, plotWidth, plotHeight - paddingH);
    CGContextStrokePath(context);

    [self drawDataColumnPlot:context];
    
}


- (void)drawDataNormalPlot:(CGContextRef) context
{
    // init variables
    float originx = paddingV; float originy = plotHeight - paddingH;
    float xAxisLength = (plotWidth - 2*paddingV)/30; // 30 days in monthly mode
    float destX = paddingV + xAxisLength;
    int counter = 1;
    
    // draw x axis label 0
    [[NSString stringWithFormat:@"%i", 0] drawInRect:
     CGRectMake(paddingV, plotHeight - 6, paddingV, paddingH)
                                                  withFont:[UIFont systemFontOfSize:paddingH - 4]
                                             lineBreakMode:NSLineBreakByWordWrapping
                                                 alignment:NSTextAlignmentLeft];
    
    
    for (NSString *str in plotSpendings) {
        float xValue = [str floatValue];
        // draw 1 data line
        [self drawLineInContext:context
                        originX:originx
                        originY:originy
                          destX:destX
                          destY:(plotHeight-paddingH) - xValue*2
                          width:1];
        
        
        // draw x axis label
        [[NSString stringWithFormat:@"%i", counter] drawInRect:
         CGRectMake(destX, plotHeight - 6, xAxisLength, paddingH)
                                                             withFont:[UIFont systemFontOfSize:paddingH - 3]
                                                        lineBreakMode:NSLineBreakByWordWrapping
                                                            alignment:NSTextAlignmentLeft];
        originx = destX;
        destX +=xAxisLength;
        originy = (plotHeight-paddingH) - xValue*2;
        //NSLog(@"data item:%@, originx:%f, originy:%f", str, originx, originy);
        
        counter++;
    }
    
}

- (void) drawDataColumnPlot:(CGContextRef)context
{
    // init variables
    float xAxisLength = (plotWidth - 2*paddingV)/30; // 30 days in monthly mode
    float originx = paddingV+xAxisLength/2; float originy = plotHeight - paddingH;
    float destX = originx;
    int counter = 1;
    
    for (NSString *str in plotSpendings) {
        float xValue = [str floatValue];
        // draw 1 data line
        [self drawLineInContext:context
                        originX:originx
                        originY:originy
                          destX:destX
                          destY:(plotHeight - paddingH) - xValue*2
                          width:xAxisLength - 0.5];
        
        
        // draw x axis label
        [[NSString stringWithFormat:@"%i", counter] drawInRect:
         CGRectMake(destX-2, plotHeight - 6, xAxisLength, paddingH)
                                                      withFont:[UIFont systemFontOfSize:paddingH - 3]
                                                 lineBreakMode:NSLineBreakByWordWrapping
                                                     alignment:NSTextAlignmentLeft];

        originx +=xAxisLength;
        destX +=xAxisLength;
        //originy = (plotHeight-paddingH) - xValue*2;
        
        counter++;
    }
    
}

- (void)drawLineInContext:(CGContextRef)context originX:(float)x1 originY:(float)y1 destX:(float)x2 destY:(float)y2 width:(float)width
{
        CGContextSetRGBStrokeColor(context, 0.6, 0.3, 0.7, 1.0);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, x1, y1);
        CGContextAddLineToPoint(context, x2, y2);
        CGContextSetLineWidth(context, width);
        CGContextStrokePath(context);
}


@end
