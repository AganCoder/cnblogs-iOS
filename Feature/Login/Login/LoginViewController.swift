//
//  WebViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/13.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit
import Foundation
import WebKit
import Common
import PKHUD
//import PromiseKit

struct CnBlogs {
    static let redirectUrl = "https://oauth.cnblogs.com/auth/callback"
    static let clientId = "c5f19532-4f2e-4439-a927-566bf9baf131"
    static let clientSecret = "Ka1IC6WD5K29nhz3DKu1H9-wYB1FKPMj7h9k7UAp6Qzvxk0dVoJe4g4lCf07FTjZRqj8eW6py2ApfDtS"
}

public class LoginFeature: Feature {
            
    public static var dependenciesInitializer: AnyInitializer {
        return AnyInitializer(Empty.init)
    }
    
    public static func build(dependencies: Empty) -> UIViewController {
        return LoginViewController()
    }
}

public class LoginViewController: UIViewController, WKScriptMessageHandler {
    
    private var webView: WKWebView? {
        didSet {
            guard let webView = webView else {
                return
            }
            webView.navigationDelegate = self            
        }
    }
    
    private var progressView: UIProgressView!
    
    private var injectRightItem: UIBarButtonItem?
        
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        title = "登录"
        navigationController?.navigationBar.isTranslucent = false
                        
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "login")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
                        
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView!)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .blue
        progressView.trackTintColor = .lightGray
        view.addSubview(progressView)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        progressView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        progressView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
                                       
        let injectRightItem = UIBarButtonItem(title: "注入", style: .done, target: self, action: #selector(injectUserInfo))
        injectRightItem.isEnabled = true
        navigationItem.rightBarButtonItem = injectRightItem
        
        self.injectRightItem = injectRightItem
    }
    
    @objc func injectUserInfo() {
        
        let userName = "gaox_219";
        let password = ""
        let jsCore = "document.getElementById('LoginName').value='\(userName)';document.getElementById('Password').value='\(password)';"
        
        // local function. don't care result
        webView?.evaluateJavaScript(jsCore, completionHandler: nil)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isMovingToParent {
            loadLoginUrlRequest()
        }
        
        webView?.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let keyPath = keyPath, keyPath == #keyPath(WKWebView.estimatedProgress), let progress = change?[NSKeyValueChangeKey.kindKey] as? Double {
            progressView.progress = Float(progress)
                        
            if (progress == 1.0) {
                progressView.isHidden = true
                
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0.0
                }, completion: nil)
            }
            return
        }
        return super.observeValue(forKeyPath: keyPath, of: object, change: change, context: nil)
    }
    
    deinit {
        self.webView?.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    private func loadLoginUrlRequest() {
        
        var body: [String: String] = [:]
        body["client_id"] = CnBlogs.clientId
        body["scope"] = "openid profile CnBlogsApi offline_access"
        body["response_type"] = "code id_token"
        body["redirect_uri"] = CnBlogs.redirectUrl
        body["state"] = "abc"
        body["nonce"] = "xyz"
            
        var component = URLComponents(string: "https://oauth.cnblogs.com/connect/authorize")
        component?.queryItems = body.map { URLQueryItem(name:$0, value: $1)}
                
        if let url = component?.url  {
            let request = URLRequest(url: url)
            webView?.load(request)
        }
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}

extension LoginViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        debugPrint(#function)
        if let urlString = navigationAction.request.url?.absoluteString,
            urlString.hasPrefix(CnBlogs.redirectUrl),
            let urlComponent = URLComponents(string: urlString.replacingOccurrences(of: "#", with: "?")),
            let codeValue = urlComponent.queryItems?.first(where: { $0.name == "code"})?.value {
            
            debugPrint(codeValue)
                        
            HUD.show(.progress)
                                                                
            var parameter: [String: String] = [:]
            parameter["client_id"] = CnBlogs.clientId
            parameter["client_secret"] = CnBlogs.clientSecret
            parameter["grant_type"] = "authorization_code"
            parameter["code"] = codeValue
            parameter["redirect_uri"] = CnBlogs.redirectUrl
                        
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
                                                
            var urlRequest = URLRequest(url: URL(string: "https://oauth.cnblogs.com/connect/token")!)
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = parameter.map({"\($0)=\($1)"}).joined(separator: "&").data(using: .utf8)
            
            let session = URLSession(configuration: configuration)
            
            session.dataTask(with: urlRequest) { (data, resp, error) in

                debugPrint(Thread.current) // not on main thread

                guard error == nil, let data = data else {
                    DispatchQueue.main.async {
                        HUD.flash(.labeledError(title: error?.localizedDescription, subtitle: nil))
                        HUD.hide(afterDelay: 0.25)
                    }
                    return
                }
                                                                                              
                let  decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .custom({ (jsonDecoder) -> Date in
                    let container = try? jsonDecoder.singleValueContainer()
                    
                    if let expiredIn = try? container?.decode(Int.self) {
                        return Date(timeIntervalSinceNow: TimeInterval(expiredIn))
                    }
                    return Date()
                })
                                            
                if case let .success(token) = Result(catching: { try decoder.decode(Token.self, from: data) }) {
                    debugPrint("acessToken: \(token)")
                    DispatchQueue.main.async { User.token = token }
                } else {
                   fatalError() // Should not be here
                }
                
                DispatchQueue.main.async { HUD.flash(.label("登录成功")); HUD.hide(afterDelay: 2.5) }
            }.resume()
    
            return decisionHandler(.cancel)
        }
        
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         debugPrint(#function)
    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
         debugPrint(#function)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrint(#function)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {

    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }

    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
}
