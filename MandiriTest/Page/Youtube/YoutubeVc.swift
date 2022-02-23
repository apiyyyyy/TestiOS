//
//  YoutubeVc.swift
//  MandiriTest
//
//  Created by Afi Permana on 23/02/22.
//

import UIKit
import WebKit

class YoutubeVc: UIViewController {
        
    let webView = WKWebView()
    var url = "https://youtube.com/watch?v="
    var key = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        let youtubeURL = url + key
        
        guard let url = URL(string: youtubeURL)else{
            return
        }
        
        webView.load(URLRequest(url: url))

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

}
