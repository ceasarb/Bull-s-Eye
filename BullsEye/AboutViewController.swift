//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Ceasar Barbosa on 5/19/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebView()
    }
    
    @IBAction func closeButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func configureWebView() {
        if let htmlFile = NSBundle.mainBundle().pathForResource("BullsEye", ofType: "html") {
            if let htmlData = NSData(contentsOfFile: htmlFile) {
                let baseURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)
                webView.loadData(htmlData, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
    }



}
