//
//  MIMarketsViewController.m
//  MarketInfo
//
//  Created by Matthew Fornaciari on 6/18/14.
//  Copyright (c) 2014 ___MATTFORNI___. All rights reserved.
//

#import "MIMarketsViewController.h"

@interface MIMarketsViewController ()

@property MIMarketData *data;
@property NSArray *markets;
@property MIMarket *selectedMarket;
@property int secondsLeft;
@property NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIPickerView *marketPicker;
@property (weak, nonatomic) IBOutlet MIOpenLabel *openLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIView *timerView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (weak, nonatomic) IBOutlet UITextField *dayField;
@property (weak, nonatomic) IBOutlet UITextField *hourField;
@property (weak, nonatomic) IBOutlet UITextField *minuteField;
@property (weak, nonatomic) IBOutlet UITextField *secondField;

@end

@implementation MIMarketsViewController

#pragma mark -
#pragma mark Core
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_marketPicker setHidden:YES];
    [_openLabel setHidden:YES];
    [_timerView setHidden:YES];
    
    _data = [[MIMarketData alloc] init];
    _markets = [NSArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(marketLoaded:) name:@"MIMarketLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(marketsLoaded:) name:@"MIMarketsLoaded" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark MarketPicker
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row < _markets.count) {
        MIMarket *picked = _markets[row];
        if (![picked.name isEqualToString:_selectedMarket.name]) {
            _selectedMarket = _markets[row];
            [self updateDisplay];
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _markets.count;
}

- (void)reloadPicker
{
    if (_markets.count > 0) {
        [_marketPicker reloadAllComponents];
        _selectedMarket = _markets[0];
        [self updateDisplay];
        
        [_spinner stopAnimating];

        [_marketPicker setHidden:NO];
        [_openLabel setHidden:NO];
        [_timerView setHidden:NO];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_markets[row] name];
}

#pragma mark -
#pragma mark Observers
- (void)marketLoaded:(NSNotification *)notification
{
    NSString *name = notification.userInfo[@"name"];
    if ([name isEqualToString:_selectedMarket.name]) {
        _selectedMarket = notification.userInfo[@"market"];
        [self performSelectorOnMainThread:@selector(updateDisplay) withObject:nil waitUntilDone:NO];
    }
}

- (void)marketsLoaded:(NSNotification *)notification
{
    _markets = notification.userInfo[@"markets"];
    [self performSelectorOnMainThread:@selector(reloadPicker) withObject:nil waitUntilDone:NO];
}

#pragma mark -
#pragma mark View
- (void)updateDisplay
{
    if (_timer != nil) { [_timer invalidate]; }
    [_openLabel setOpen:_selectedMarket.open];
    if (_selectedMarket.open) {
        _timerLabel.text = @"Closes In";
        _secondsLeft = [_selectedMarket.closesAt timeIntervalSinceDate:[NSDate date]];
    } else {
        _timerLabel.text = @"Opens In";
        _secondsLeft = [_selectedMarket.opensAt timeIntervalSinceDate:[NSDate date]];
    }
    [self updateTimer];
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self
        selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void) updateTimer
{
    _secondsLeft--;
    if (_secondsLeft <= 0) {
        [_timer invalidate];
        _timer = nil;
        [_data loadMarket:_selectedMarket.name];
    }

    int days = _secondsLeft / 86400;
    int hours = (_secondsLeft % 86400) / 3600;
    int minutes = ((_secondsLeft % 86400) % 3600) / 60;
    int seconds = ((_secondsLeft % 86400) % 3600) % 60;

    _dayField.text = [NSString stringWithFormat:@"%02d", days];
    _hourField.text = [NSString stringWithFormat:@"%02d", hours];
    _minuteField.text = [NSString stringWithFormat:@"%02d", minutes];
    _secondField.text = [NSString stringWithFormat:@"%02d", seconds];
}

@end
