#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Preferences/PSSpecifier.h"
#import "Preferences/PSControlTableCell.h"

@interface POTimeStepperTableCell : PSControlTableCell {
	NSString *title;
}
@property (nonatomic, retain) UIStepper *control;
@end

@implementation POTimeStepperTableCell

@dynamic control;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier]) {
		self.accessoryView = self.control;
        [self.detailTextLabel setHidden:YES];
	}
	return self;
}

- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];
	title = [specifier propertyForKey:@"label"];
	[self _updateLabel];
}

- (UIStepper *)newControl {
	UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
	stepper.continuous = NO;
	stepper.value = 0;
	stepper.minimumValue = 0;
	stepper.maximumValue = 10;
	return stepper;
}

- (NSNumber *)controlValue {
	return @(self.control.value);
}

- (void)setValue:(NSNumber *)value {
	[super setValue:value];
    self.control.value = value.doubleValue;
}

- (void)controlChanged:(UIStepper *)stepper {
	[super controlChanged:stepper];
	[self _updateLabel];
}

- (void)_updateLabel {
	if (!self.control) {
		return;
	}

	int value = (int)self.control.value;
	NSString *pointStr = (value == 1) ? @"Second" : @"Seconds";
    NSString *valString = [NSString stringWithFormat:@"%i", value];
    self.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", title, valString, pointStr];

	[self setNeedsLayout];
}

@end
