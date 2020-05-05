//
//  CategoryCell.swift
//  News API
//
//  Created by Cao Mai on 4/22/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var newSourceCategoryColor: UILabel!
    @IBOutlet weak var newsSourceCategoryLabel: UILabel!
    @IBOutlet weak var categoryLabelName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 9
//        self.newSourceCategoryColor.layer.cornerRadius = newSourceCategoryColor.frame.size.width/2
//        newSourceCategoryColor.text = ""
//        newSourceCategoryColor.backgroundColor = .blue
//        newSourceCategoryColor.layer.masksToBounds = true
        setRound()

    }
    
    func setRound() {
                newSourceCategoryColor.text = ""
                newSourceCategoryColor.backgroundColor = .blue
        let width:CGFloat = UIScreen.main.bounds.width*0.0533
//        newSourceCategoryColor.frame = CGRect(x: 0,y: 0,width: width,height: width)
        newSourceCategoryColor.layer.masksToBounds = true
        newSourceCategoryColor.layer.cornerRadius = width/2
    }
    
    
}
