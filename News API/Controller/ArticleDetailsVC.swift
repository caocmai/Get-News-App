//
//  ArticleDetailsVC.swift
//  News API
//
//  Created by Cao Mai on 4/30/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class ArticleDetailsVC: UIViewController {
    
    var article: Article!
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        articleTitleLabel.text = "title"
        //        articleText.text = "somthing"
        setContent()
        
    }
    
    func setContent() {
        //        print(article!)
        articleTitleLabel.text = article!.title!
        articleText.text = article!.content!
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
