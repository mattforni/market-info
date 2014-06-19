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
@property (weak, nonatomic) IBOutlet UIPickerView *marketPicker;
@property (weak, nonatomic) IBOutlet MIStatusLabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

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
    [_statusLabel setHidden:YES];
    
    _data = [[MIMarketData alloc] init];
    _markets = [NSArray array];
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
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark MarketPicker
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row < _markets.count) {
        _selectedMarket = _markets[row];
        [self updateDisplay];
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
        [_statusLabel setHidden:NO];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_markets[row] name];
}

#pragma mark -
#pragma mark Observers
- (void)marketsLoaded:(NSNotification *)notification
{
    _markets = notification.userInfo[@"markets"];
    [self performSelectorOnMainThread:@selector(reloadPicker) withObject:nil waitUntilDone:NO];
}

#pragma mark -
#pragma mark View
- (void)updateDisplay
{
    [_statusLabel setOpen:_selectedMarket.open];
}


@end
