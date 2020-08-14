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
    
    var sources : [NewsSource] = [] {
        didSet {
            self.filteredSources = sources
            //            sourcesCollectionView.reloadData()
            applySnapshot() // Calling this instead of reloading collectionview
        }
    }
    
    var filteredSources: [NewsSource] = []
    var articles: [Article] = []
    
    enum Section { // For creating snapshots
        case main
    }
    
    // These 3 lines of code are applicable for snapshots along with main section
    typealias DataSource = UICollectionViewDiffableDataSource<Section, NewsSource>
    
    private lazy var dataSource = makeDataSource()
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, NewsSource>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSources()
        configureCollectionView()
        configureNavbarAndSearchbar()
        applySnapshot(animatingDifferences: false)
    }
    
    // These two methods are for snapshots
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: sourcesCollectionView, cellProvider:  { (collectionView, indexPath, sources) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.categoryCellID, for: indexPath) as! CategoryCell
            let sourceCategory = self.filteredSources[indexPath.row].category
            
            switch sourceCategory?.capitalized {
            case K.general:
                cell.newSourceCategoryColor.backgroundColor = CategoryColor.generalColor.rawValue
            case K.business:
                cell.newSourceCategoryColor.backgroundColor = CategoryColor.businessColor.rawValue
            case K.science:
                cell.newSourceCategoryColor.backgroundColor = CategoryColor.scienceColor.rawValue
            case K.technology:
                cell.newSourceCategoryColor.backgroundColor = CategoryColor.techColor.rawValue
            case K.health:
                cell.newSourceCategoryColor.backgroundColor = CategoryColor.healthColor.rawValue
            case K.entertainment:
                cell.newSourceCategoryColor.backgroundColor = CategoryColor.entertainColor.rawValue
            case K.sports:
                cell.newSourceCategoryColor.backgroundColor = CategoryColor.sportsColor.rawValue
            default:
                cell.newSourceCategoryColor.backgroundColor = CategoryColor.generalColor.rawValue
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
    
    func configureCollectionView() {
        sourcesCollectionView.dataSource = self
        sourcesCollectionView.delegate = self
        sourcesCollectionView.register(UINib(nibName: K.categoryCell, bundle: .main), forCellWithReuseIdentifier: K.categoryCellID)
    }
    
    func configureNavbarAndSearchbar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Top News by Source"
        self.navigationController!.tabBarItem.title = "Sources"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(showAlertOptions(controller:)))
        search.delegate = self
        search.placeholder = "Filter news sources"
        search.returnKeyType = UIReturnKeyType.done
        hideKeyboard()
    }
    
    @objc func showAlertOptions(controller: UIViewController) {
        let alert = UIAlertController(title: "Sort By", message: "Choose how news sources are ordered by", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Category", style: .default, handler: { (_) in
            self.sort(sources: &self.filteredSources)
            //            self.sourcesCollectionView.reloadData()
            self.applySnapshot() // Applying snapshots instead
        }))
        alert.addAction(UIAlertAction(title: "Default", style: .default, handler: { (_) in
            self.fetchSources()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
        }))
        
        self.present(alert, animated: true, completion:nil)
    }
    
    func fetchSources() {
        NetworkManager.singleton.getSources() { result in
            switch result {
            case let .success(returnedSources):
                self.sources = returnedSources!.sources
            case let .failure(gotError):
                print(gotError)
            }
        }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.categoryCellID, for: indexPath) as! CategoryCell
        // No need to set anything here because now using snapshot method instead
        return cell
    }
}

extension SourcesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedSource = filteredSources[indexPath.row].id else {
            return
        }
                
        NetworkManager.singleton.getArticlesFromSource(from: selectedSource) { result in
            switch result {
            case let .success(gotArticles):
                //                print(gotArticles)
                let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let headLineVC  = sampleStoryBoard.instantiateViewController(withIdentifier: K.headlinesCellID) as! HeadlinesVC
                headLineVC.headlines = gotArticles!
                headLineVC.sourceName = self.filteredSources[indexPath.row].name
                self.navigationController?.pushViewController(headLineVC, animated: true)
                
            case let .failure(gotError):
                print(gotError)
            }
        }
    }
}

//MARK: - Searchbar

extension SourcesVC: UISearchBarDelegate {
    func hideKeyboard() {
        // To hide the keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        // This to make sure other things are still clickable after hiding keyboard
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredSources = filteredSearch(for: searchText)
        applySnapshot()
    }
    
    // Filtered search logic
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search.resignFirstResponder() // To dismiss keyboard w/ return tapped
    }
    
}
