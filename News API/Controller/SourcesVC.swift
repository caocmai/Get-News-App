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
    @IBOutlet weak var search: UISearchBar!
    
    enum Section {
      case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, NewsSource>
    private lazy var dataSource = makeDataSource()
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, NewsSource>

    var sources : [NewsSource] = [] {
        didSet {
            self.filteredSources = sources
//            sourcesCollectionView.reloadData()
            applySnapshot() // Calling this instead of reloading collectionview
        }
    }
    
    var filteredSources: [NewsSource] = []
    
    let networkManager = NetworkManager()
    var articles: [Article] = []
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: sourcesCollectionView, cellProvider:  { (collectionView, indexPath, sources) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
            
            let sourceCategory = self.filteredSources[indexPath.row].category
                                    
                  switch sourceCategory?.capitalized {
                  case K.general:
                      cell.newSourceCategoryColor.backgroundColor = ProjectColor.generalColor.rawValue
                  case K.business:
                      cell.newSourceCategoryColor.backgroundColor = ProjectColor.businessColor.rawValue
                  case K.science:
                      cell.newSourceCategoryColor.backgroundColor = ProjectColor.scienceColor.rawValue
                  case K.technology:
                      cell.newSourceCategoryColor.backgroundColor = ProjectColor.techColor.rawValue
                  case K.health:
                      cell.newSourceCategoryColor.backgroundColor = ProjectColor.healthColor.rawValue
                  case K.entertainment:
                      cell.newSourceCategoryColor.backgroundColor = ProjectColor.entertainColor.rawValue
                  case K.sports:
                      cell.newSourceCategoryColor.backgroundColor = ProjectColor.sportsColor.rawValue
                  default:
                      cell.newSourceCategoryColor.backgroundColor = ProjectColor.generalColor.rawValue
                  }
                  cell.backgroundColor = #colorLiteral(red: 0.9561000466, green: 0.941519022, blue: 0.9314298034, alpha: 1)
            cell.categoryLabelName.text = self.filteredSources[indexPath.row].name
                  cell.categoryLabelName.textColor = #colorLiteral(red: 0.05834504962, green: 0.05800623447, blue: 0.05861062557, alpha: 1)
                  cell.newsSourceCategoryLabel.text = sourceCategory?.capitalized
            return cell
        })
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var localSnapchat = Snapshot()
        localSnapchat.appendSections([.main])
        localSnapchat.appendItems(filteredSources)
        dataSource.apply(localSnapchat, animatingDifferences: animatingDifferences)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSources()
        configureCollectionView()
        configureNavbarAndSearchbar()
        applySnapshot(animatingDifferences: false)
    }
    
    func configureCollectionView() {
        sourcesCollectionView.dataSource = self
        sourcesCollectionView.delegate = self
        sourcesCollectionView.register(UINib(nibName: "CategoryCell", bundle: .main), forCellWithReuseIdentifier: "categoryCell")
    }
    
    func configureNavbarAndSearchbar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Top News by Source"
        self.navigationController!.tabBarItem.title = "Sources"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(showOptions(controller:)))
        search.delegate = self
        search.placeholder = "Filter news sources"
        hideKeyboard()
    }
    
    @objc func showOptions(controller: UIViewController) {
        
        let alert = UIAlertController(title: "Sort By", message: "Choose how news sources are ordered", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Category", style: .default, handler: { (_) in
            self.sort(sources: &self.filteredSources)
//            self.sourcesCollectionView.reloadData()
            self.applySnapshot()
        }))
        alert.addAction(UIAlertAction(title: "Default", style: .default, handler: { (_) in
            self.fetchSources()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
        }))
        
        self.present(alert, animated: true, completion:nil)
    }
    
    func fetchSources() {
        networkManager.getSources() { result in
            switch result {
            case let .success(returnedSources):
                self.sources = returnedSources!.sources
                
            case let .failure(gotError):
                print(gotError)
            }
        }
        //        print(sources)
    }
    
    func sort(sources: inout [NewsSource]) {
        sources.sort(by: {
            var isSorted = false // In order to upwrap the optional
            if let first = $0.category, let second = $1.category {
                isSorted = first < second
            }
            return isSorted
        })
    }
}


extension SourcesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredSources.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        //        cell.backgroundColor = uiColors[indexPath.row]
//        let sourceCategory = filteredSources[indexPath.row].category
//                
//        switch sourceCategory?.capitalized {
//        case K.general:
//            cell.newSourceCategoryColor.backgroundColor = ProjectColor.generalColor.rawValue
//        case K.business:
//            cell.newSourceCategoryColor.backgroundColor = ProjectColor.businessColor.rawValue
//        case K.science:
//            cell.newSourceCategoryColor.backgroundColor = ProjectColor.scienceColor.rawValue
//        case K.technology:
//            cell.newSourceCategoryColor.backgroundColor = ProjectColor.techColor.rawValue
//        case K.health:
//            cell.newSourceCategoryColor.backgroundColor = ProjectColor.healthColor.rawValue
//        case K.entertainment:
//            cell.newSourceCategoryColor.backgroundColor = ProjectColor.entertainColor.rawValue
//        case K.sports:
//            cell.newSourceCategoryColor.backgroundColor = ProjectColor.sportsColor.rawValue
//        default:
//            cell.newSourceCategoryColor.backgroundColor = ProjectColor.generalColor.rawValue
//        }
//        cell.backgroundColor = #colorLiteral(red: 0.9561000466, green: 0.941519022, blue: 0.9314298034, alpha: 1)
//        cell.categoryLabelName.text = filteredSources[indexPath.row].name
//        cell.categoryLabelName.textColor = #colorLiteral(red: 0.05834504962, green: 0.05800623447, blue: 0.05861062557, alpha: 1)
//        cell.newsSourceCategoryLabel.text = sourceCategory?.capitalized
//        
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
        guard let selectedSource = filteredSources[indexPath.row].id else {
            return
        }
        
        print(selectedSource)
        
        networkManager.getArticlesFromSource(from: selectedSource) { result in
            switch result {
            case let .success(gotArticles):
                //                print(gotArticles)
                let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let headLineVC  = sampleStoryBoard.instantiateViewController(withIdentifier: "headlinesVC") as! HeadlinesVC
                headLineVC.headlines = gotArticles!
                headLineVC.category = self.filteredSources[indexPath.row].name
                self.navigationController?.pushViewController(headLineVC, animated: true)
                
            case let .failure(gotError):
                print(gotError)
            }
        }

    }
    
}

extension SourcesVC: UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 165, height: 165)
       }
       
       func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 17, bottom: 0, right: 17)
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


extension SourcesVC: UISearchBarDelegate {
    
    func hideKeyboard() {
        // To hide the keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        // This to make sure other things are still clickable after hiding keyboard
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    // Trying to hide keyboard when users changes mind of searching
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print(searchBar.text!)
//        if searchBar.text! == "" {
//            self.filteredSources = sources
//            self.sourcesCollectionView.reloadData()
//        } else {
//            self.filteredSources = sources.compactMap {$0}.filter({($0.name?.contains(searchBar.text!.lowercased()))!})
//            print(self.filteredSources)
//            self.sourcesCollectionView.reloadData()
//
//        }
//
//    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
//        if searchText == "" {
//            self.filteredSources = sources
//            self.sourcesCollectionView.reloadData()
//        } else {
//            self.filteredSources = sources.compactMap {$0}.filter({($0.name?.lowercased().contains(searchText.lowercased()))!})
//            print(self.filteredSources)
//            self.sourcesCollectionView.reloadData()
//
//        }
        //Appying snapshots instead
        filteredSources = filteredSearch(for: searchText)
        applySnapshot()
    }
    
    func filteredSearch(for queryOrNil: String?) -> [NewsSource] {
        let allNewSources = self.sources
      guard let query = queryOrNil, !query.isEmpty
        else {
          return allNewSources
      }
      return allNewSources.filter {
        return $0.name!.lowercased().contains(query.lowercased())
      }
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Search for news sources"
            return false
        }
    }
    
}
