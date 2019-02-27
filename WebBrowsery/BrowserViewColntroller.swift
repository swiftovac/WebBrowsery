//
//  BrowserViewColntroller.swift
//  WebBrowsery
//
//  Created by Stefan Milenkovic on 2/27/19.
//  Copyright © 2019 Stefan Milenkovic. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewColntroller: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressBar: UIProgressView!
    
    
    var retreivedWebSite: String?
    
    override func loadView() {
        
        
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.sizeToFit()
        
        guard let adress = retreivedWebSite else {return}
        guard let url = URL(string: "https://" + adress) else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let forw = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        let progress = UIBarButtonItem(customView: progressBar)
        
        toolbarItems = [progress,space, back, forw,refresh]
        navigationController?.isToolbarHidden = false
        
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
    }
    
    
    
    
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        
        
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressBar.progress = Float(webView.estimatedProgress)
        }
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        if let host = url?.host {
            if let site = retreivedWebSite {
                if host.contains(site) {
                    decisionHandler(.allow)
                    return
                }
                
                
            }
        }
        
        
        
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        presentAlert()
    }
    
    
    
    
 

func presentAlert() {
    
    let ac = UIAlertController(title: "Wrong adress", message: "Please check your web adress again", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Back to pages", style: .default, handler: { (action) in
        
        //navigationController?.dismiss(animated: true, completion: nil)
        
        self.navigationController?.popViewController(animated: true)
    }))
    
    present(ac, animated: true, completion: nil)
    
}





}
