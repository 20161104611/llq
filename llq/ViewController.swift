//
//  ViewController.swift
//  llq
//
//  Created by 16wb395 on 2019/1/4.
//  Copyright © 2019 16wb395. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController {

    @IBOutlet weak var result: UITextField!
    
    @IBOutlet weak var webView: WKWebView!
    
    lazy private var progressView: UIProgressView = {
        self.progressView = UIProgressView.init(frame: CGRect(x: CGFloat(0), y: CGFloat(65), width: UIScreen.main.bounds.width, height: 2))
        self.progressView.tintColor = UIColor.blue      // 进度条颜色
        self.progressView.trackTintColor = UIColor.white // 进度条背景色
        return self.progressView
    }()
    let progressview = UIProgressView (frame:CGRect.init(x:0,y:0,width:200,height:10))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        view.addSubview(progressView)
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.load(URLRequest.init(url: URL.init(string: "https://www.baidu.com/")!))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress"{
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    



    @IBAction func go(_ sender: Any) {
        let url = result.text
        webView.load(NSURLRequest(url:NSURL(string:"http://"+url!)!as URL)as URLRequest)
    }
    @IBAction func gotoclick(_ sender: Any) {
        webView.goForward()
    }
    @IBAction func gobackclick(_ sender: Any) {
        webView.goBack()
    }
    @IBAction func refreshclick(_ sender: Any) {
        webView.reload()
    }
    
    


}

