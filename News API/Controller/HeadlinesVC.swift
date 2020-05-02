//
//  HeadlinesVC.swift
//  News API
//
//  Created by Cao Mai on 4/22/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class HeadlinesVC: UIViewController {
    
    @IBOutlet weak var headlinesTableView: UITableView!
    var category: String? = nil
    var headlines: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headlinesTableView)
        headlinesTableView.delegate = self
        headlinesTableView.dataSource = self
        title = category!
    }
}

extension HeadlinesVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath) as! HeadlinesCell
        cell.setHeadlines(for: headlines[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // To display the actual html of the story
        let vc = DetailNewsStoryVC()
        vc.url = headlines[indexPath.row].url
        self.navigationController?.pushViewController(vc, animated: true)
        
        // To display contents from New API article
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "articleDetailsVC") as! ArticleDetailsVC
        //        vc.article = headlines[indexPath.row]
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

