//
//  ViewController.m
//  WebViewAutoLayout
//
//  Created by Shawn Wall on 11/19/13.
//  Copyright (c) 2013 TwoTap Labs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *htmlStrings;

-(void)loadTestViews;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"WebView AutoLayout";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.htmlStrings = @[@"<html><body>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam consequat pharetra mi, vel pharetra sapien. Integer sodales purus quis urna faucibus blandit. Nulla commodo dolor sem, ut dictum leo fringilla et. Pellentesque ultricies semper pretium. Vestibulum ultrices euismod quam. Sed ut vulputate lectus, at eleifend tortor. Praesent suscipit ante at vulputate blandit. Suspendisse odio elit, varius sit amet eros at, volutpat venenatis sem.</body></html>",
                         @"<html><body>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec gravida congue ornare. Aliquam vulputate erat sit amet blandit dapibus. Maecenas sollicitudin tincidunt erat. Maecenas dignissim dolor vel ligula mattis aliquam. Vivamus lacinia tellus sit amet ligula lobortis, et volutpat ipsum laoreet. Curabitur cursus gravida magna, sit amet vestibulum sem venenatis et. Nulla facilisi. Cras congue tristique faucibus. Sed eu luctus massa. Nunc justo enim, condimentum vitae pellentesque a, tempor eget nibh. Donec lobortis ut mi nec feugiat. Ut pretium risus dui, et condimentum diam placerat eget. Cras laoreet nulla ligula, vel tristique sapien ullamcorper a. Nulla non bibendum enim. Suspendisse purus tortor, mollis vel ullamcorper et, mollis non lacus. Aenean eu dictum metus, eget pellentesque nunc. Nulla vehicula enim id arcu dapibus pellentesque. Donec ut arcu viverra, suscipit massa luctus, iaculis nulla. Donec sit amet urna condimentum, aliquam augue sit amet, euismod nisl. Morbi consequat, ligula pellentesque ultricies gravida, nunc nibh pulvinar libero, fringilla vulputate magna lectus ac erat.</body></html>",
                         @"<html><body>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam consequat pharetra mi, vel pharetra sapien. </body></html>",
                         @"<html><body>Nulla non bibendum enim. Suspendisse purus tortor, mollis vel ullamcorper et, mollis non lacus. Aenean eu dictum metus, eget pellentesque nunc. Nulla vehicula enim id arcu dapibus pellentesque. Donec ut arcu viverra, suscipit massa luctus, iaculis nulla. Donec sit amet urna condimentum, aliquam augue sit amet, euismod nisl. Morbi consequat, ligula pellentesque ultricies gravida, nunc nibh pulvinar libero, fringilla vulputate magna lectus ac erat.</body></html>",
                         @"<html><body>Lorem ipsum dolor sit amet, consectetur adipiscing elit. </body></html>",
                         @"<html><body>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec gravida congue ornare. Aliquam vulputate erat sit amet blandit dapibus. Maecenas sollicitudin tincidunt erat. Maecenas dignissim dolor vel ligula mattis aliquam. Vivamus lacinia tellus sit amet ligula lobortis, et volutpat ipsum laoreet. Curabitur cursus gravida magna, sit amet vestibulum sem venenatis et. Nulla facilisi. Cras congue tristique faucibus. Sed eu luctus massa. Nunc justo enim, condimentum vitae pellentesque a, tempor eget nibh. Donec lobortis ut mi nec feugiat. Ut pretium risus dui, et condimentum diam placerat eget. Cras laoreet nulla ligula, vel tristique sapien ullamcorper a. Nulla non bibendum enim. Suspendisse purus tortor, mollis vel ullamcorper et, mollis non lacus. Aenean eu dictum metus, eget pellentesque nunc. Nulla vehicula enim id arcu dapibus pellentesque. Donec ut arcu viverra, suscipit massa luctus, iaculis nulla. Donec sit amet urna condimentum, aliquam augue sit amet, euismod nisl. Morbi consequat, ligula pellentesque ultricies gravida, nunc nibh pulvinar libero, fringilla vulputate magna lectus ac erat.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec gravida congue ornare. Aliquam vulputate erat sit amet blandit dapibus. Maecenas sollicitudin tincidunt erat. Maecenas dignissim dolor vel ligula mattis aliquam. Vivamus lacinia tellus sit amet ligula lobortis, et volutpat ipsum laoreet. Curabitur cursus gravida magna, sit amet vestibulum sem venenatis et. Nulla facilisi. Cras congue tristique faucibus. Sed eu luctus massa. Nunc justo enim, condimentum vitae pellentesque a, tempor eget nibh.</body></html>"];
    [self loadTestViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)loadTestViews {
    UIWebView *lastWebView = nil;
    for (NSString *html in self.htmlStrings) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        webView.delegate = self;
        webView.translatesAutoresizingMaskIntoConstraints = NO;
        [webView loadHTMLString:html baseURL:nil];
        [self.view addSubview:webView];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
        [self.view addConstraint:leftConstraint];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
        [self.view addConstraint:rightConstraint];
        if (lastWebView) {
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:lastWebView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0];
            [self.view addConstraint:topConstraint];
        }
        lastWebView = webView;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *scrollHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    NSLog(@"scrollHeight: %@", scrollHeight);
    NSLog(@"webview.contentSize.height %f", webView.scrollView.contentSize.height);
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:[scrollHeight floatValue]];
    [webView addConstraint:heightConstraint];
    NSLog(@"webview frame %@", NSStringFromCGRect(webView.frame));

}

@end
