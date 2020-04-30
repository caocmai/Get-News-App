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

        // Do any additional setup after loading the view.
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

extension HeadlinesVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath) as! HeadlinesCell

//        cell.backgroundColor = .blue
//        cell.headlineLabel.text = "test is a test"
        cell.headlineLabel.text = headlines[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let headLineVC  = sampleStoryBoard.instantiateViewController(withIdentifier: "headlinesVC") as! HeadlinesVC
        
        let vc = DetailNewsStoryVC()
        vc.url = headlines[indexPath.row].url
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

