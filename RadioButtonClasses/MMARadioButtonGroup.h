//
//  MMARadioButtonGroup.h
//  Dhanesh Gosai
//
//  Created by DhaneshMac on 17/06/13.
//  Copyright (c) 2013 Dhanesh Gosai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMARadioButtonGroup;
@protocol MMARadioButtonGroupDelegate <NSObject>

@optional

-(void)radioButtonSelected:(MMARadioButtonGroup*)RadioButtonView selectedRadioIndex:(int)radioSelectedIndex;

@end


@interface MMARadioButtonGroup : UIView {
	NSMutableArray *radioButtons;
    NSArray *optionArr;

}

@property (nonatomic,retain) NSMutableArray *radioButtons;
@property (nonatomic,retain) id <MMARadioButtonGroupDelegate> delegate;
@property (nonatomic,retain) NSArray *optionArr;
@property (nonatomic,assign) int QueId,SubQueId;
- (id)initWithFrame:(CGRect)frame andOptions:(NSArray *)options andColumns:(int)columns andRadioType:(NSString*)type;
-(IBAction) radioButtonClicked:(UIButton *) sender;
-(void) removeButtonAtIndex:(int)index;
-(void) setSelected:(int) index;
-(void)clearAll;



@end
