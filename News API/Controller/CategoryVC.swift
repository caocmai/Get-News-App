//
//  ViewController.swift
//  News API
//
//  Created by Cao Mai on 4/22/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit
// Show the source in the tableview, maybe add icon to it,

class CategoryVC: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let category = ["General", "Business", "Science", "Technology", "Health", "Entertainment", "Sports"]
//    let uiColors = [#colorLiteral(red: 0.1176470588, green: 0.6980392157, blue: 0.6509803922, alpha: 1), #colorLiteral(red: 0.831372549, green: 0.9725490196, blue: 0.9098039216, alpha: 1), #colorLiteral(red: 1, green: 0.6392156863, blue: 0.3019607843, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.8492380977, green: 0, blue: 0.3497368693, alpha: 1)]
    
    
    let networkManager = NetworkManager()
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: .main), forCellWithReuseIdentifier: "categoryCell")
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News by Category"
        self.navigationController!.tabBarItem.title = "Categories"
        
        searchBar.delegate = self
        searchBar.placeholder = "Search for news"
        hideKeyboard()
    }
}


extension CategoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        let categoryName = category[indexPath.row]
        
        switch categoryName {
        case K.general:
            cell.backgroundColor = ProjectColor.generalColor.rawValue
        case K.business:
            cell.backgroundColor = ProjectColor.businessColor.rawValue
        case K.science:
            cell.backgroundColor = ProjectColor.scienceColor.rawValue
        case K.technology:
            cell.backgroundColor = ProjectColor.techColor.rawValue
        case K.health:
            cell.backgroundColor = ProjectColor.healthColor.rawValue
        case K.entertainment:
            cell.backgroundColor = ProjectColor.entertainColor.rawValue
        case K.sports:
            cell.backgroundColor = ProjectColor.sportsColor.rawValue
        default:
            cell.backgroundColor = ProjectColor.generalColor.rawValue
        }
        
        //        cell.backgroundColor = uiColors[indexPath.row]
        cell.categoryLabelName.text = categoryName
        cell.categoryLabelName.textColor = #colorLiteral(red: 0.05834504962, green: 0.05800623447, blue: 0.05861062557, alpha: 1)
        cell.newsSourceCategoryLabel.isHidden = true
        cell.newSourceCategoryColor.isHidden = true
        
        // last item in cell
        if indexPath.row == category.count - 1 {
            print("last item in array")
            
        }
        return cell
    }
}

extension CategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = category[indexPath.row]
        
        networkManager.getArticles(passedInCategory: selectedCategory.lowercased()) { result in
            switch result {
            case let .success(gotArticles):
                //                print(gotArticles)
                let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let headLineVC  = sampleStoryBoard.instantiateViewController(withIdentifier: "headlinesVC") as! HeadlinesVC
                headLineVC.headlines = gotArticles!
                headLineVC.category = self.category[indexPath.row]
                self.navigationController?.pushViewController(headLineVC, animated: true)
                
            case let .failure(gotError):
                print(gotError)
            }
        }
    }
}

extension CategoryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 165)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 12, bottom: 10, right: 12)
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

//MARK: - Search bar method

extension CategoryVC: UISearchBarDelegate {
    
    func hideKeyboard() {
        // To hide the keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        // This to make sure other things are still clickable after hiding keyboard
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchQueryText = searchBar.text!
        searchBar.endEditing(true)
        
        // This to handle spaces
        var searchQuery = ""
        for letter in searchQueryText {
            if letter == " " {
                searchQuery += "%20"
            }else {
                searchQuery += String(letter)
            }
            
        }
        
        networkManager.getSearchArticles(passedInQuery: searchQuery) { result in
            switch result {
            case let .success(gotArticles):
                //                print(gotArticles)
                let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                
                let headLineVC  = sampleStoryBoard.instantiateViewController(withIdentifier: "headlinesVC") as! HeadlinesVC
                headLineVC.headlines = gotArticles!
                if gotArticles!.isEmpty {
                    headLineVC.category = "No Results for \(searchQueryText)"
                    self.navigationController?.pushViewController(headLineVC, animated: true)
                    
                }else {
                    headLineVC.category = "Results for \(searchQueryText)"
                    self.navigationController?.pushViewController(headLineVC, animated: true)
                }
                
            case let .failure(gotError):
                print(gotError)
            }
        }
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Enter a search phrase"
            return false
        }
    }
    
}
