//
//  ViewController.swift
//  News API
//
//  Created by Cao Mai on 4/22/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    let test = "https://newsapi.org/v2/sources?apiKey=cb3a1eac41554355a9bbf8612b87d638&category=business"
    let APIKEY = "cb3a1eac41554355a9bbf8612b87d638"
    let allSources = "https://newsapi.org/v2/sources?apiKey=cb3a1eac41554355a9bbf8612b87d638"
    
    var newsSources = [NewsSources]()
    let category2 = ["General", "Business", "Science", "Technology", "Health", "Entertainment", "Sports"]
    
    var category = ["general": "", "business": "", "science": "", "technology": "", "health": "", "entertainment": "", "sports": ""]
    
    let networkManager = NetworkManager()
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: .main), forCellWithReuseIdentifier: "categoryCell")
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Homepage"
        fetchNewsSources(url: allSources)
        
        updateArticles()
        
        
    }
    
    func updateArticles() {
        networkManager.getArticles(){ result in
            switch result {
            case let .success(gotArticles):
                self.articles = gotArticles
            case let .failure(gotError):
                print(gotError)
            }
//            print(result)
        }
    }
    
//    func getSources() {
//        for new in newsSources {
//            print(new.sources)
//        }
//    }
    
    func fetchNewsSources(url: String) {
            
            //TODO: Create session configuration here
            let defaultSession = URLSession(configuration: .default)
            
            //TODO: Create URL (...and send request and process response in closure...)
            if let url = URL(string: url) {
                
                //TODO: Create Request here
                let request = URLRequest(url: url)
                
                
                // Create Data Task...
                let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                    
                    //                print("data is: ", data!)
                    //                print("response is: ", response!)
                    
                    do {
                        //                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: [])
                        
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let newSource = try decoder.decode(NewsSources.self, from: data!)
    //                    print(pokemons)
                        self.newsSources = [newSource]
                        
                        
                        DispatchQueue.main.async {
//                            self.table.reloadData()
//                            for new in self.newsSources {
//                                print(new.sources)
//                            }
//                            self.getSources()
                            for stuff in (self.newsSources[0].sources) {
                                if ((self.category[stuff.category]) != nil) {
                                    self.category[stuff.category]! += "\(stuff.id),"
                                }
                            }
                            print(self.category["business"]!.dropLast())
                        }
                        //                    print(self.pokemons)
                        //                    print(pokemons.results[0].name)
                        
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                    
                })
                dataTask.resume()
            }
        }
    
}

//national-geographic,national-geographicnew-scientist,new-scientistnext-big-future,next-big-future
//national-geographic,new-scientist,next-big-future,




extension CategoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        cell.backgroundColor = .blue
        cell.categoryLabelName.text = category2[indexPath.row]
        return cell
    }
    
    
}

extension CategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let newVS = HeadlinesVC()
        
        //        self.present(newVS, animated: true, completion: nil)
        
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        
        let headLineVC  = sampleStoryBoard.instantiateViewController(withIdentifier: "headlinesVC") as! HeadlinesVC
        
        headLineVC.category = category2[indexPath.row]
        self.navigationController?.pushViewController(headLineVC, animated: true)
        
        //        let newsVC = DetailNewsStoryVC()
        //        self.present(newsVC, animated: true, completion: nil)
        
        
    }
}

extension CategoryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 185)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 30, bottom: 10, right: 30)
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
