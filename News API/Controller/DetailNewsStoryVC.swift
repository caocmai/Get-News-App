//
//  DetailNewsStoryVC.swift
//  News API
//
//  Created by Cao Mai on 4/22/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit
import WebKit

class DetailNewsStoryVC: UIViewController {
    
    var url: String? = nil
    let webPage = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
        getWebPage(from: url!)
        
        
        view.backgroundColor = .black
        
    }
    
    func setUp(){
        self.view.addSubview(webPage)
        webPage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webPage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            webPage.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            webPage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webPage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func getWebPage(from url: String) {
        let toURL = URL(string: url)
//        print(url2!)
        let request = URLRequest(url: toURL!)
        webPage.load(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
