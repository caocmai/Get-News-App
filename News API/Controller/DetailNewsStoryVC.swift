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
    
    let url: String? = nil
    let showPage = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
        
        let url2 = URL(string: "https://www.youtube.com/")
        print(url2!)
        let request = URLRequest(url: url2!)
        showPage.load(request)
        view.backgroundColor = .black
        
    }
    
    func setUp(){
        self.view.addSubview(showPage)
        showPage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showPage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            showPage.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            showPage.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            showPage.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
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
