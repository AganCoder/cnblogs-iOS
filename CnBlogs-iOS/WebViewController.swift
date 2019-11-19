//
//  WebViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/13.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
        
    var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView(frame: view.bounds)
        webView.delegate = self
        self.webView = webView
        view.addSubview(webView)
        
        
        var body: [String: String] = [:]
        body["client_id"] = "c5f19532-4f2e-4439-a927-566bf9baf131"
        body["scope"] = "openid profile CnBlogsApi offline_access"
        body["response_type"] = "code id_token"
        body["redirect_uri"] = "https://oauth.cnblogs.com/auth/callback"
        body["state"] = "abc"
        body["nonce"] = "xyz"
        
        var component = URLComponents(string: "https://oauth.cnblogs.com/connect/authorize")
        component?.queryItems = body.map { URLQueryItem(name:$0, value: $1)}
        if let url = component?.url {
            print(url)
            
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
//    var url: String?
//
//    var webView: WKWebView? {
//        didSet {
//            self.webView?.uiDelegate = self
//            self.webView?.navigationDelegate = self
//        }
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        webView = WKWebView(frame: view.bounds)
//
//        if let webView = webView {
//            view.addSubview(webView)
//
//            guard let url = URL(string: "https://oauth.cnblogs.com/connect/authorize") else {
//                return
//            }
//
//            webView.load(URLRequest(url: url))
//        }
//
//
//    }
}

//extension WebViewController: WKUIDelegate, WKNavigationDelegate {
//
//}


extension WebViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool
    {
        print(request.url?.absoluteString ?? "")
        return true
    }

      
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        
    }

      
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        
    }

     func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        
    }
}
