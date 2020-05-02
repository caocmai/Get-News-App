//
//  SourcesVC.swift
//  News API
//
//  Created by Cao Mai on 4/30/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class SourcesVC: UIViewController {
    
    @IBOutlet weak var sourcesCollectionView: UICollectionView!
    let category = ["BBC", "CNN", "Science", "Technology", "Health", "Entertainment", "Sports"]
    
    var sources : [NewsSource] = [] {
        didSet {
            sourcesCollectionView.reloadData()
        }
    }
    
    let uiColors = [#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)]
    let networkManager = NetworkManager()
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourcesCollectionView.dataSource = self
        sourcesCollectionView.delegate = self
        sourcesCollectionView.register(UINib(nibName: "CategoryCell", bundle: .main), forCellWithReuseIdentifier: "categoryCell")
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Top News by Source"
        self.navigationController!.tabBarItem.title = "Sources"
        fetchSources()
    }
    
    func fetchSources() {
        networkManager.getSources() { result in
            switch result {
            case let .success(source):
                self.sources = source!.sources                
            case let .failure(gotError):
                print(gotError)
            }
        }
//        print(sources)
    }
}


extension SourcesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sources.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
//        cell.backgroundColor = uiColors[indexPath.row]
        cell.backgroundColor = .orange
        cell.categoryLabelName.text = sources[indexPath.row].name
        
        return cell
    }
}

extension SourcesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let newVS = HeadlinesVC()
        
        //        self.present(newVS, animated: true, completion: nil)
        
        //        networkManager.getArticles(passedInCategory: "health"){ result in
        //            switch result {
        //            case let .success(gotArticles):
        //                self.articles = gotArticles
        //            case let .failure(gotError):
        //                print(gotError)
        //            }
        guard let selectedSource = sources[indexPath.row].id else {
            return
        }
        
        networkManager.getArticlesFromSource(from: selectedSource) { result in
            switch result {
            case let .success(gotArticles):
                //                print(gotArticles)
                let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                
                let headLineVC  = sampleStoryBoard.instantiateViewController(withIdentifier: "headlinesVC") as! HeadlinesVC
                headLineVC.headlines = gotArticles!
                headLineVC.category = self.sources[indexPath.row].name
                self.navigationController?.pushViewController(headLineVC, animated: true)
                
            case let .failure(gotError):
                print(gotError)
            }
        }
        //        let newsVC = DetailNewsStoryVC()
        //        self.present(newsVC, animated: true, completion: nil)
        
    }
    
}

extension SourcesVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 13, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}


