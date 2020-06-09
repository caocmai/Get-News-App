//
//  CustomFlowLayout.swift
//  News API
//
//  Created by Cao Mai on 5/27/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class CustomFlowLayout:  UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        let totalWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
//        let maxNumColumns = Int(availableWidth / minColumnWidth)
        let padding: CGFloat = 10
        let minimumItemSpacing: CGFloat = 15
        let availableWidth = totalWidth - (padding * 2) - minimumItemSpacing
        let cellWidth = (availableWidth / 2)
        
        self.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        self.itemSize = CGSize(width: cellWidth, height: cellWidth)
        self.sectionInsetReference = .fromSafeArea
    }

}
