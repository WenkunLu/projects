//
//  ViewController.swift
//  ShanyBroser
//
//  Created by Master Lu on 2022/5/14.
//

import UIKit
import WebKit

let hostNameForLocalFile = ""

class ViewController: UIViewController {
    
    var webView: WKWebView!

    let textField = TextFieldWithPadding()
    var leftView = UIView()
    let backViewOfField = UIView()
    var backViewToTabBarCon1: NSLayoutConstraint!
    var backViewBottom1: NSLayoutConstraint!
    var backViewBottom2: NSLayoutConstraint!
    
    var progressBar: UIView!
    var progressBarWidthConstraint: NSLayoutConstraint!
    
    let tabBar = UITabBar()
    var firstItem: UITabBarItem!
    var secondItem: UITabBarItem!
    let barAppearance = UITabBarAppearance()

    var getClick: Bool = false {
        didSet {
            changeConstraintOfTextField(isis: getClick)
        }
    }

    var currentContentMode: WKWebpagePreferences.ContentMode?
    var contentModeToRequestForHost: [String: WKWebpagePreferences.ContentMode] = [:]
    
    var estimatedProgressObservationToken: NSKeyValueObservation?
    var canGoBackObservationToken: NSKeyValueObservation?
    var canGoForwardObservationToken: NSKeyValueObservation?

    
    //MARK: - ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let configuration = WKWebViewConfiguration()
        configuration.applicationNameForUserAgent = "Version/1.0 ShinyBrowser/1.0"

        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 400, height: 400), configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .systemBlue
        webView.navigationDelegate = self
        
        let myURL = URL(string:"https://bilibili.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        progressBar = UIView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.backgroundColor = .tintColor
        backViewOfField.addSubview(progressBar)
        
        view.addSubview(webView)
        view.addSubview(tabBar)
        view.addSubview(backViewOfField)
        
        setupField()
        setupTabBar()
        
        var loadedExistingURL = false
        if let lastCommittedURLStringString = UserDefaults.standard.object(forKey: "LastCommitted") as? String {
            if let url = URL(string: lastCommittedURLStringString) {
                textField.text = lastCommittedURLStringString
                webView.load(URLRequest(url: url))
                loadedExistingURL = true
            }
        }
        
        layoutWhenViewDidLoad()
        setUpObservation()
        
        textField.clearButtonMode = .always
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBar.standardAppearance = barAppearance

        firstItem.isEnabled = false
        secondItem.isEnabled = false
    }

    
    
    func setUpObservation() {
        estimatedProgressObservationToken = webView.observe(\.estimatedProgress) { (object, change) in
            let estimatedProgress = self.webView.estimatedProgress
            self.progressBarWidthConstraint.constant = CGFloat(estimatedProgress) * (self.view.bounds.width)
            self.progressBar.alpha = 1
            if estimatedProgress >= 1 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.progressBar.alpha = 0
                }, completion: { (finished) in
                    self.progressBarWidthConstraint.constant = 0
                })
            }
        }

        canGoBackObservationToken = webView.observe(\.canGoBack) { (object, change) in
            //self.backButton.isEnabled = self.webView.canGoBack
            self.firstItem.isEnabled = self.webView.canGoBack
            print(self.firstItem.isEnabled)
        }

        canGoForwardObservationToken = webView.observe(\.canGoForward) { (object, change) in
            //self.forwardButton.isEnabled = self.webView.canGoForward
            self.secondItem.isEnabled = self.webView.canGoForward
            print(self.secondItem.isEnabled)
        }
    }
}

//MARK: - NavigationDelegate
extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//        if let url = webView.url {
//            if url.scheme != "file" {
//                if let urlString = webView.url?.absoluteString {
//                    UserDefaults.standard.set(urlString, forKey: "LastCommitted")
//                    textField.text = urlString
//                }
//            } else {
//                UserDefaults.standard.removeObject(forKey: "LastCommitted")
//                textField.text = url.lastPathComponent
//            }
//        }

//        textField.text = webView.url?.absoluteString
        currentContentMode = navigation.effectiveContentMode
    }

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 preferences: WKWebpagePreferences,
                 decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        if let hostName = navigationAction.request.url?.host {

            if let preferredContentMode = contentModeToRequestForHost[hostName] {
                preferences.preferredContentMode = preferredContentMode
            }
        } else if navigationAction.request.url?.scheme == "file" {
            if let preferredContentMode = contentModeToRequestForHost[hostNameForLocalFile] {
                preferences.preferredContentMode = preferredContentMode
            }
        }
        decisionHandler(.allow, preferences)
    }
    
    
}

//MARK: - TextField Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        getClick = true
        backViewOfField.backgroundColor = .tertiaryLabel
        textField.leftView = UIView()
        textField.leftViewMode = .always
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        //设置搜索框的样式
        getClick = false
        backViewOfField.backgroundColor = .clear
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        //设置搜索框动作
        guard var urlString = textField.text?.lowercased() else {
            return
        }

        if !urlString.contains("://") {
            if urlString.contains("localhost") || urlString.contains("127.0.0.1") {
                urlString = "http://" + urlString
            } else {
                urlString = "https://" + urlString
            }
        }

        if webView.url?.absoluteString == urlString {
            return
        }

        if let targetURL = URL(string: urlString) {
            webView.load(URLRequest(url: targetURL))
        }
    }
}




