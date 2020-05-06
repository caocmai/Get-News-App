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
        newSourceCategoryColor.backgroundColor = .yellow
        newSourceCategoryColor.text = "LL"
        newSourceCategoryColor.textColor = .clear
        newSourceCategoryColor.layer.masksToBounds = true
        newSourceCategoryColor.layer.cornerRadius  = 15
//        self.newSourceCategoryColor.layer.cornerRadius = newSourceCategoryColor.frame.size.width/2
//        newSourceCategoryColor.text = ""
//        newSourceCategoryColor.backgroundColor = .blue
//        newSourceCategoryColor.layer.masksToBounds = true
//        setRound()
//        testButton.titleLabel!.text = ""
//        testButton.backgroundColor = .blue
//        testButton.layer.shadowColor = UIColor.black.cgColor
//        testButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        testButton.layer.masksToBounds = false
//        testButton.layer.shadowRadius = 1.0
//        testButton.layer.shadowOpacity = 0.5
//        testButton.layer.cornerRadius = testButton.frame.width / 2
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
