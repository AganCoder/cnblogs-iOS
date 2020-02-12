//
//  WebViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/13.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit
import WebKit
import Common
import Alamofire


public class LoginFeature: Feature {
            
    public static var dependenciesInitializer: AnyInitializer {
        return AnyInitializer(Empty.init)
    }
    
    public static func build(dependencies: Empty) -> UIViewController {
        return LoginViewController()
    }
}


public class LoginViewController: UIViewController {
    
    private var webView: WKWebView? {
        didSet {
            guard let webView = webView else {
                return
            }
            webView.uiDelegate = self
            webView.navigationDelegate = self
        }
    }
    
    private var injectRightItem: UIBarButtonItem?
        
    override public func viewDidLoad() {
        super.viewDidLoad()
                
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView!)
        
        let injectRightItem = UIBarButtonItem(title: "注入", style: .done, target: self, action: #selector(injectUserInfo))
        injectRightItem.isEnabled = false
        self.navigationItem.rightBarButtonItem = injectRightItem
        
        self.injectRightItem = injectRightItem
    }
    
    @objc func injectUserInfo() {
        debugPrint(#function)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.isMovingToParent {
            loadLoginUrlRequest()
        }
    }
    
    private func loadLoginUrlRequest() {
        var body: [String: String] = [:]
        body["client_id"] = "c5f19532-4f2e-4439-a927-566bf9baf131"
        body["scope"] = "openid profile CnBlogsApi offline_access"
        body["response_type"] = "code id_token"
        body["redirect_uri"] = "https://oauth.cnblogs.com/auth/callback"
        body["state"] = "abc"
        body["nonce"] = "xyz"
            
        var component = URLComponents(string: "https://oauth.cnblogs.com/connect/authorize")
        component?.queryItems = body.map { URLQueryItem(name:$0, value: $1)}
                
        if let url = component?.url  {
            let request = URLRequest(url: url)
            webView?.load(request)
        }
    }
}

extension LoginViewController: WKNavigationDelegate {
    
    // 是否允许加载一个页面，其中包含两种情况
    //         1. 正常加载页面或者点击跳转页面
    //         2. 服务器端重定向页面也会进行询问
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // debugPrint("decidePolicyFor navigationAction")
        decisionHandler(.allow)
    }
    
    //  Called when web content begins to load in a web view.
    //  当 Web 开始加载网络的数据，未渲染前的时候回调用，注意: 此方法目前测试只会调用一次，就是 load 内容的时候，回调用该方法
    //      1. 页面跳转，例如点击了网页的 href 跳转到另一个页面，不会调用该方法
    //      2. 重定向内容也不回调用该方法
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // debugPrint(#function)
        // debugPrint("Called when web content begins to load in a web view.")
    }
    
    // Called when a web view receives a server redirect.
    // 服务器端重定向问题
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        // debugPrint(#function)
    }
    
    // 加载完成网络临时数据，渲染之前询问是否需要进行渲染，允许就会渲染
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        // debugPrint("decidePolicyFor navigationResponse")
        decisionHandler(.allow)
    }
    
    // Called when the web view begins to receive web content.
    // 开始把本地的临时数据载入到网页中
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        // debugPrint("didCommit")
    }
    
    // Called when the navigation is complete
    // 完成本地内容的渲染
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // debugPrint("didFinish")
    }
    
    // 加载临时数据失败的时候会进行调用
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // debugPrint(#function)
    }
    
    // 渲染失败的时候会进行调用
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // debugPrint(#function)
    }

    // Terminate 的时候回调用
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        // debugPrint(#function)
    }
    
}

extension LoginViewController: WKUIDelegate {
    
    /** @abstract Creates a new web view.
     @param webView The web view invoking the delegate method.
     @param configuration The configuration to use when creating the new web
     view. This configuration is a copy of webView.configuration.
     @param navigationAction The navigation action causing the new web view to
     be created.
     @param windowFeatures Window features requested by the webpage.
     @result A new web view or nil.
     @discussion The web view returned must be created with the specified configuration. WebKit will load the request in the returned web view.
    
     If you do not implement this method, the web view will cancel the navigation.
     */
    
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        debugPrint(#function)
        return nil
    }

    
    /** @abstract Notifies your app that the DOM window object's close() method completed successfully.
      @param webView The web view invoking the delegate method.
      @discussion Your app should remove the web view from the view hierarchy and update
      the UI as needed, such as by closing the containing browser tab or window.
      */
    @available(iOS 9.0, *)
    public func webViewDidClose(_ webView: WKWebView) {
        debugPrint(#function)
    }

    
    /** @abstract Displays a JavaScript alert panel.
     @param webView The web view invoking the delegate method.
     @param message The message to display.
     @param frame Information about the frame whose JavaScript initiated this
     call.
     @param completionHandler The completion handler to call after the alert
     panel has been dismissed.
     @discussion For user security, your app should call attention to the fact
     that a specific website controls the content in this panel. A simple forumla
     for identifying the controlling website is frame.request.URL.host.
     The panel should have a single OK button.
    
     If you do not implement this method, the web view will behave as if the user selected the OK button.
     */
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        debugPrint(#function)
    }

    
    /** @abstract Displays a JavaScript confirm panel.
     @param webView The web view invoking the delegate method.
     @param message The message to display.
     @param frame Information about the frame whose JavaScript initiated this call.
     @param completionHandler The completion handler to call after the confirm
     panel has been dismissed. Pass YES if the user chose OK, NO if the user
     chose Cancel.
     @discussion For user security, your app should call attention to the fact
     that a specific website controls the content in this panel. A simple forumla
     for identifying the controlling website is frame.request.URL.host.
     The panel should have two buttons, such as OK and Cancel.
    
     If you do not implement this method, the web view will behave as if the user selected the Cancel button.
     */
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        debugPrint(#function)
    }

    
    /** @abstract Displays a JavaScript text input panel.
     @param webView The web view invoking the delegate method.
     @param prompt The prompt to display.
     @param defaultText The initial text to display in the text entry field.
     @param frame Information about the frame whose JavaScript initiated this call.
     @param completionHandler The completion handler to call after the text
     input panel has been dismissed. Pass the entered text if the user chose
     OK, otherwise nil.
     @discussion For user security, your app should call attention to the fact
     that a specific website controls the content in this panel. A simple forumla
     for identifying the controlling website is frame.request.URL.host.
     The panel should have two buttons, such as OK and Cancel, and a field in
     which to enter text.
    
     If you do not implement this method, the web view will behave as if the user selected the Cancel button.
     */
    
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        debugPrint(#function)
    }

}
