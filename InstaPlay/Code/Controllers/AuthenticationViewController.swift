//
//  AuthenticationViewController.swift
//  InstaPlay
//
//  Created by Vincent Douant on 11/07/2018.
//  Copyright © 2018 Vincent Douant. All rights reserved.
//

import UIKit
import WebKit
import InstagramKit

class AuthenticationViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webview: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webview.load(URLRequest(url: InstagramEngine.shared().authorizationURL(for: .publicContent)))
        webview.navigationDelegate = self
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url, url.absoluteString.starts(with: "https://www.thanksys.com/") else {
            decisionHandler(.allow)
            return
        }
        do {
            try InstagramEngine.shared().receivedValidAccessToken(from: url)
            decisionHandler(.allow)
        } catch {
            decisionHandler(.cancel)
        }
    }
}
