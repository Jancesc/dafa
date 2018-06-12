//
//  ngg_webViewController.m
//  Dafa
//
//  Created by jan on 2018/6/12.
//  Copyright © 2018 Unity. All rights reserved.
//

#import "ngg_webViewController.h"
#import "NSDictionary+Extension.h"
#import <WebKit/WebKit.h>
#import "FCAlertView.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
#import "ngg_commonMacro.h"

NSString *kScreenCallbackNotification = @"screenCallbackNotification";

@interface ngg_webViewController ()<WKNavigationDelegate> {
   
    WKWebView *_webView;
}

@property (nonatomic, assign) BOOL firstTime;
@property (nonatomic, assign) NSString *urlString;

@end

@implementation ngg_webViewController

#pragma mark - view life circle
- (void)loadView {
   
    UIView *view = [[UIView alloc] initWithFrame:SCREEN_BOUNDS];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
    [self configueUI:view];
}

- (void)configueUI:(UIView  *)view {
  
    _webView = [[WKWebView alloc] initWithFrame:SCREEN_BOUNDS];
    _webView.scrollView.backgroundColor = [UIColor whiteColor];

    [view addSubview:_webView];
    _webView.navigationDelegate = self;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)viewDidLoad {
 
    [super viewDidLoad];
    _urlString = @"https://g1.p1000y.com/game/";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenCallbackNotification:) name:kScreenCallbackNotification object:nil];
    _firstTime = YES;
    [self loadRequest];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadRequest {

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [_webView loadRequest:request];
}

- (void)clearCache {
    
    NSSet *websiteDataTypes
    = [NSSet setWithArray:@[
                            WKWebsiteDataTypeDiskCache,
                            WKWebsiteDataTypeMemoryCache,
                            ]];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    //// Execute
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        // Done
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self clearCache];
    
}

#pragma mark - message hub
- (void)showLoadingHUDWithText:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.label.text = text;
}

- (void)dismissHUD {
    
    [MBProgressHUD hideHUDForView:self.view animated:NO];
}

#pragma mark - screen Notification
- (void)screenCallbackNotification:(NSNotification *)notification {
    
    //    onScreenCallback
    //    state: 为1表示屏幕亮起，为0表示屏幕熄灭
    
    NSInteger code = [notification.userInfo intForKey:@"code"];
    
    NSString *JSString = [NSString stringWithFormat:@"onScreenCallback('%ld')", code];
    [_webView evaluateJavaScript:JSString completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        NSLog(@"onScreenCallback");
    }];
}

#pragma mark - OpenSafari
- (void) openSafari:(NSString *)url {
    
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)url, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    NSLog(@"%@", decodedString);
    NSString *urlStr = [decodedString componentsSeparatedByString:@"//url="][1];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

#pragma mark - CopyToClipboard
- (void) copyToClipboard:(NSString *)reqUrl {
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)reqUrl, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    NSLog(@"%@", decodedString);
    NSString *contentStr = [decodedString componentsSeparatedByString:@"//content="][1];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = contentStr;
}


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy policy))decisionHandler {

    // NOTE: ------  对alipays:相关的scheme处理 -------
    // NOTE: 若遇到支付宝相关scheme，则跳转到本地支付宝App
    NSString* reqUrl = navigationAction.request.URL.absoluteString;
    if ([reqUrl hasPrefix:@"alipays://"] || [reqUrl hasPrefix:@"alipay://"]) {
        // NOTE: 跳转支付宝App
        BOOL bSucc = [[UIApplication sharedApplication]openURL:navigationAction.request.URL];
        
        // NOTE: 如果跳转失败，则跳转itune下载支付宝App
        if (!bSucc) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"未检测到支付宝客户端，请安装后重试。"
                                                          delegate:self
                                                 cancelButtonTitle:@"立即安装"
                                                 otherButtonTitles:nil];
            [alert show];
        }
        
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([reqUrl hasPrefix:@"openSystemBrowser://"]) { //打开外部浏览器
        
        [self openSafari:reqUrl];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([reqUrl hasPrefix:@"copyToClipboard://"]) { //复制到粘贴板
        
        [self copyToClipboard:reqUrl];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    if (_firstTime) {
        [self showLoadingHUDWithText:nil];
    }
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%@", @"接收到重定向时会回调");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if (_firstTime) {
        [self dismissHUD];
        FCAlertView *alert = [[FCAlertView alloc] init];
        alert.blurBackground = YES;
        [alert makeAlertTypeCaution];
        [alert showAlertInView:self withTitle:@"网络出错" withSubtitle:@"网络状态不稳定，请检查手机网络连接状态!" withCustomImage:nil withDoneButtonTitle:@"重新加载" andButtons:nil];
        alert.doneBlock = ^{
            [self loadRequest];
        };
    } else {
    }
    NSLog(@"%@", @"导航失败时会回调");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%@", @"导航完成时，会回调（也就是页面载入完成了）");
    if (_firstTime) {
        
        [self dismissHUD];
        _webView.scrollView.backgroundColor = [UIColor blackColor];
        _firstTime = NO;
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
}

@end
