//
//  WebViewController.swift
//  Favorite_Pages
//
//  Created by Pankaj Sharma on 3/20/18.
//  Copyright © 2018 Pankaj Sharma. All rights reserved.
//

import UIKit

protocol BookMarkProtocol {
    func saveWebLink(title: String, url: String)
}

class WebViewController: UIViewController, UIWebViewDelegate {
    
    var myDelegate: BookMarkProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveLinkTapped))
      
      
        showWebView()
    }

    
    @objc func saveLinkTapped() {
        showAlertAction()
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
   var myURLString = ""
    let addressTextField: UITextField = {
        let tf = UITextField()
        return tf
    }()
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        guard let myURL = webView.request?.url?.absoluteString else { return }
        myURLString = myURL
        
        
    }
    let webView: UIWebView = {
        let webview = UIWebView()
        
        
        
        return webview
    }()
    
    func showWebView() {
        webView.delegate = self
        view.addSubview(webView)
        
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let url = URL(string: "https://www.google.com")
        webView.loadRequest(URLRequest(url: url!))
        
    }
    func loadWebPage() {
        
           let url = URL(string: myURLString)
            webView.loadRequest(URLRequest(url: url!))
        }
    
    func showAlertAction() {
        let alert = UIAlertController(title: "Add Bookmark", message: "Customize your weblink", preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Type your page name"
         }
        
       alert.addAction(UIAlertAction(title: "Save", style: .default) { (showAlert) in
        
            if let textfield = alert.textFields?.first {
                self.myDelegate?.saveWebLink(title: textfield.text!, url: self.myURLString)
             }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
}
}
