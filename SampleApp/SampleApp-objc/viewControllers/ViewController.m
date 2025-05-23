#import "ViewController.h"
#import "SampleAppEventDelegateHandler.h"
#import "SetIdVerificationTheme.h"

typedef NS_ENUM(NSInteger, ButtonActionType) {
    ButtonActionSetCustomTheme = 1,
    ButtonActionSetDefaultTheme,
    ButtonActionScanGenericDocument,
    ButtonActionScanIDCard,
    ButtonActionScanPassport,
    ButtonActionScanOddDocument
};

@interface ViewController ()
@property (strong, nonatomic) IdVerificationHandler *verificationHandler;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.verificationHandler = [[IdVerificationHandler alloc] initWithPresenter:self];
    
    // Calculate safe area top inset
    CGFloat topSafeArea = 0;
    if (@available(iOS 11.0, *)) {
      topSafeArea = self.view.safeAreaInsets.top + 20;
    }

    NSArray *buttonTitles = @[
        @"Set Custom Theme",
        @"Set Default Theme",
        @"Scan Generic Document",
        @"Scan Id-card / Driving License",
        @"Scan Passport",
        @"Scan Odd Document"
    ];
    CGFloat buttonSpacing = 50;

    // Create title label
    UILabel *titleLabel = [self createTitleLabel:topSafeArea + 10];
    [self.view addSubview:titleLabel];

    CGFloat initialY = CGRectGetMaxY(titleLabel.frame) + 10;

    // Create scan button's
    for (int i = 0; i < buttonTitles.count; i++) {
        CGFloat buttonY = initialY + (i * buttonSpacing);
        UIButton *button = [self createButtonWithTitle:buttonTitles[i] tag:(i + 1) yPosition:buttonY];
        [self.view addSubview:button];
    }

    // Create result label
    CGFloat lastButtonY = initialY + (buttonTitles.count * buttonSpacing);
    self.statusLabel = [self createResultLabel:lastButtonY];
    [self.view addSubview:self.statusLabel];

     // Create and setup spinner
     [self createSpinner];
}

#pragma mark - UI Component Helpers

- (UILabel *)createTitleLabel:(CGFloat)topInset {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, topInset + 10, self.view.frame.size.width - 20, 80)];
    titleLabel.text = @"Sample Application\n\n365id Id Verification SDK";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    return titleLabel;
}

- (void)createSpinner {
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.spinner.center = self.view.center;
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
}

- (UIButton *)createButtonWithTitle:(NSString *)title tag:(NSInteger)tag yPosition:(CGFloat)y {
    CGFloat buttonWidth = [UIScreen mainScreen].bounds.size.width - 40;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, y, buttonWidth, 40);
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = UIColor.blueColor;
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    button.tag = tag;
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UILabel *)createResultLabel:(CGFloat)y {
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 40;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y, width, 300)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor darkTextColor];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont systemFontOfSize:16];
    return label;
}

#pragma mark - Button Action

// Action method for all buttons
- (void)buttonTapped:(UIButton *)sender {
    ButtonActionType actionType = sender.tag;

    NSString *message = @"";
    SetIdVerificationTheme *setTheme = [[SetIdVerificationTheme alloc] init];

    switch (actionType) {
      case ButtonActionSetCustomTheme:
          message = @"Set Custom Theme";
          [setTheme setCustomTheme];
          break;
    case ButtonActionSetDefaultTheme:
        message = @"Set Custom Theme";
        [setTheme setDefaultTheme];
        break;
      case ButtonActionScanGenericDocument:
          message = @"Scan Generic Document";
          [self.verificationHandler startVerificationWithDocumentSize:DocumentSizeTypeDocument];
          break;
      case ButtonActionScanIDCard:
          message = @"Scan ID-card / Driving License";
          [self.verificationHandler startVerificationWithDocumentSize:DocumentSizeTypeId1];
          break;
      case ButtonActionScanPassport:
          message = @"Scan Passport";
          [self.verificationHandler startVerificationWithDocumentSize:DocumentSizeTypeId3];
          break;
      case ButtonActionScanOddDocument:
          message = @"Scan Odd Document";
          [self.verificationHandler startVerificationWithDocumentSize:DocumentSizeTypeOdd];
          break;
      default:
          message = @"Unknown Action";
          break;
    }

    NSLog(@"User selected: %@.", message);
}

#pragma mark - Status Label Updates

- (void)updateTransactionResult:(NSString *)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        // self.statusLabel.text = result;
        
        NSString *existingText = self.statusLabel.text ?: @"";
        NSString *updatedText = [NSString stringWithFormat:@"%@\n%@", existingText, result];
        self.statusLabel.text = updatedText;
        
        // Calculate and update label height based on text content
        CGSize maxSize = CGSizeMake(self.statusLabel.frame.size.width, CGFLOAT_MAX);
        CGSize expectedSize = [self.statusLabel sizeThatFits:maxSize];

        CGRect newFrame = self.statusLabel.frame;
        newFrame.size.height = expectedSize.height;  // Adjust the height dynamically
        self.statusLabel.frame = newFrame;
    });
}

- (void)resetTransactionResult {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.statusLabel.text = @"";
    });
}

- (void)showSpinner:(BOOL)isLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (isLoading) {
            [self.spinner startAnimating];
            self.spinner.hidden = NO;
            
            // Hide all buttons
            for (UIView *subview in self.view.subviews) {
                if ([subview isKindOfClass:[UIButton class]]) {
                    subview.hidden = YES;
                }
            }
        } else {
            [self.spinner stopAnimating];
            self.spinner.hidden = YES;
            
            // Show all buttons
            for (UIView *subview in self.view.subviews) {
                if ([subview isKindOfClass:[UIButton class]]) {
                    subview.hidden = NO;
                }
            }
        }
    });
}


@end
