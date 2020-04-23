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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: .main), forCellWithReuseIdentifier: "categoryCell")
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "YAY"

    }


}

extension CategoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        cell.backgroundColor = .blue
        cell.categoryLabelName.text = "YO, what sup"
        return cell
    }
    
    
}

extension CategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("yay, selected")
//        let newVS = HeadlinesVC()
        
//        self.present(newVS, animated: true, completion: nil)

        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)


        let homeView  = sampleStoryBoard.instantiateViewController(withIdentifier: "headlinesVC") as! HeadlinesVC



        self.navigationController?.pushViewController(homeView, animated: true)
        
//        let newsVC = DetailNewsStoryVC()
//        self.present(newsVC, animated: true, completion: nil)


    }
}
