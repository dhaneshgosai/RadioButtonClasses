//
//  MMARadioButtonGroup.m
//  Dhanesh Gosai
//
//  Created by DhaneshMac on 17/06/13.
//  Copyright (c) 2013 Dhanesh Gosai. All rights reserved.
//

#import "MMARadioButtonGroup.h"

@implementation MMARadioButtonGroup
@synthesize radioButtons;
@synthesize delegate;
@synthesize optionArr;
@synthesize QueId,SubQueId;

- (id)initWithFrame:(CGRect)frame andOptions:(NSArray *)options andColumns:(int)columns andRadioType:(NSString*)type{
	
	NSMutableArray *arrTemp =[[NSMutableArray alloc]init];
	self.radioButtons =arrTemp;
    self.optionArr = options;
	[arrTemp release];
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		int framex =0;
		framex= frame.size.width/columns;
		int framey = 0;
		framey =frame.size.height/([options count]/(columns));
		int rem =[options count]%columns;
		if(rem !=0){
			framey =frame.size.height/(([options count]/columns)+1);
		}
		int k = 0;
		for(int i=0;i<([options count]/columns);i++){
			for(int j=0;j<columns;j++){
				
			    int x = framex*0.25;
				int y = framey*0.25;
                UIButton *btTemp;
                if (appDelegate.isIpad && ([type isEqualToString:@"semantic"] || [type isEqualToString:@"semantic_six"]))  {
                    btTemp = [[UIButton alloc]initWithFrame:CGRectMake(framex*j+x+18, 0, 30, framey/2+y+10)];
                    btTemp.tag=j;
                }else{
                   btTemp = [[UIButton alloc]initWithFrame:CGRectMake(10, framey*i+y, frame.size.width-20, framey/2+y)];
                    btTemp.tag=i;
                }

                
				[btTemp addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
				btTemp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
				[btTemp setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
			    [btTemp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				btTemp.titleLabel.font =[UIFont fontWithName:kAppSupportedFontNormal size:12];
                if (appDelegate.isIpad && ([type isEqualToString:@"semantic"] || [type isEqualToString:@"semantic_six"])){
                   [btTemp setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
                    
                }else{
                    [btTemp setTitle:[NSString stringWithFormat:@"%@",[options objectAtIndex:k]] forState:UIControlStateNormal];
                    btTemp.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
                    int numLine=[self getLabelLine:[NSString stringWithFormat:@"%@",[options objectAtIndex:k]] andLabelFont:btTemp.titleLabel.font andLabelFrame:btTemp.frame];
                    btTemp.titleLabel.numberOfLines=0;
                    btTemp.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
                    btTemp.frame=CGRectMake(btTemp.frame.origin.x, btTemp.frame.origin.y,btTemp.frame.size.width,(17*numLine));
                    if (numLine>1) {
                        btTemp.titleLabel.numberOfLines=(numLine+1);
                        btTemp.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
                        btTemp.frame=CGRectMake(btTemp.frame.origin.x, btTemp.frame.origin.y,btTemp.frame.size.width,(14*(numLine+1)));
                    }

                }
				
                btTemp.backgroundColor=[UIColor clearColor];
				[self.radioButtons addObject:btTemp];
				[self addSubview:btTemp];
		        [btTemp release];
				k++;
		
			}
		}
		
			for(int j=0;j<rem;j++){
				
			    int x = framex*0.25;
				int y = framey*0.25;
				UIButton *btTemp = [[UIButton alloc]initWithFrame:CGRectMake(framex*j+x, framey*([options count]/columns), framex/2+x, framey/2+y)];
                btTemp.tag=j;
				[btTemp addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
				btTemp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
				[btTemp setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
			    [btTemp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				btTemp.titleLabel.font =[UIFont systemFontOfSize:14.f];
				[btTemp setTitle:[NSString stringWithFormat:@" %@",[options objectAtIndex:k]] forState:UIControlStateNormal];
				[self.radioButtons addObject:btTemp];
				[self addSubview:btTemp];
				[btTemp release];
		        k++;
				
			
		}	
		
	}
    return self;
}

- (void)dealloc {
	[radioButtons release];
    [super dealloc];
}

-(IBAction) radioButtonClicked:(UIButton *) sender{
	for(int i=0;i<[self.radioButtons count];i++){
		[[self.radioButtons objectAtIndex:i] setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
	
	}
	[sender setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
    [delegate radioButtonSelected:self selectedRadioIndex:[sender tag]];

}

-(void) removeButtonAtIndex:(int)index{
	[[self.radioButtons objectAtIndex:index] removeFromSuperview];

}

-(void) setSelected:(int) index{
	for(int i=0;i<[self.radioButtons count];i++){
		[[self.radioButtons objectAtIndex:i] setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
		
	}
	[[self.radioButtons objectAtIndex:index] setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
    


}

-(void)clearAll{
	for(int i=0;i<[self.radioButtons count];i++){
		[[self.radioButtons objectAtIndex:i] setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
		
	}

}

#pragma mark ---
                                                    
-(int)getLabelLine:(NSString*)aLabelText andLabelFont:(UIFont*)aLabelFont andLabelFrame:(CGRect)aLabelFrame
{
    CGSize fontSize = [aLabelText sizeWithFont:aLabelFont];
    int atitleNumberOfLines = fontSize.width/aLabelFrame.size.width + 1;
    return atitleNumberOfLines;
}
                                                    
@end
