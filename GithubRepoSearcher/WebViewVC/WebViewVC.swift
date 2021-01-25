//
//  WebViewVC.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import UIKit
import WebKit


class WebViewVC: UIViewController {
    var dialogLoading: ActivityVC? = nil
    @IBOutlet weak var webViewPage: WKWebView!
    var pageLink: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    func initView() {
        webViewPage.navigationDelegate = self
        
        let urlRequest = URLRequest(url: URL(string: pageLink)!)
        webViewPage.load(urlRequest)
    }

}

extension WebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        dialogLoading = ActivityVC.showProgressDialog("")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActivityVC.hideDialog(dialogLoading)
    }
}
