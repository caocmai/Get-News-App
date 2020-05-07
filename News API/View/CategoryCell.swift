//
//  CategoryCell.swift
//  News API
//
//  Created by Cao Mai on 4/22/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var newSourceCategoryColor: UIImageView!
    @IBOutlet weak var newsSourceCategoryLabel: UILabel!
    @IBOutlet weak var categoryLabelName: UILabel!
    
    @IBOutlet weak var imageViewTest: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 9
        newSourceCategoryColor.backgroundColor = .yellow
//        newSourceCategoryColor.text = "LL" // Placehold to have that size
//        newSourceCategoryColor.textColor = .clear
        newSourceCategoryColor.layer.masksToBounds = true
        newSourceCategoryColor.layer.cornerRadius  = 15
//        imageViewTest.isHidden = true
//        imageViewTest.layer.cornerRadius = 15
//        imageViewTest.clipsToBounds = true
    }
    
   
    
    
}
