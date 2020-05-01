//
//  HeadlinesCell.swift
//  News API
//
//  Created by Cao Mai on 4/22/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit
import Kingfisher

class HeadlinesCell: UITableViewCell {
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var headlineImage: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headlineImage.image = UIImage(named: "beach")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setHeadlines(for article: Article) {
        
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        if let safeTitle = article.title {
            headlineLabel.text = safeTitle
        }
        let processor = RoundCornerImageProcessor(cornerRadius: 40)
        headlineImage.kf.indicatorType = .activity

        
        if let safeImageURL = article.urlToImage {
        headlineImage.kf.setImage(with: URL(string: safeImageURL), options: [.processor(processor), .transition(.fade(0.2))]) { result in
            switch result {
            case .success(let value):
//                print(value.image)
                print("sucess")
            case .failure(let error):
//                print(error)
                print("No IMAGE TO SHOW CAN'T FETCH")
                self.headlineLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor).isActive = true
            }
            
        }
        }
    }

}
