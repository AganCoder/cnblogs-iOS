//
//  WebViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/13.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    
    var webView: WKWebView? {
        didSet {
            guard let webView = webView else {
                return
            }
            webView.uiDelegate = self
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        
        guard let url = component?.url else {
            debugPrint("Error!!")
            return
        }
            
        let request = URLRequest(url: url)
        webView?.load(request)
    }
    
}

extension LoginViewController: WKUIDelegate, WKNavigationDelegate {

}
