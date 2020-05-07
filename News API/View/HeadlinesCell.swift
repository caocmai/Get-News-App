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
    @IBOutlet weak var headlineSource: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setHeadlines(for article: Article) {
        
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        if let safeTitle = article.title {
            headlineLabel.text = safeTitle
        }
        
        if let safeSource = article.source.name {
            headlineSource.text = safeSource
        }
        
        let processor = RoundCornerImageProcessor(cornerRadius: 40)
        headlineImage.kf.indicatorType = .activity
        
        
        if let safeImageURL = article.urlToImage {
            headlineImage.kf.setImage(with: URL(string: safeImageURL), options: [.processor(processor), .transition(.fade(0.2))]) { result in
                switch result {
                case .success(let value):
                    //                print(value.image)
                    print("sucess")
                    self.headlineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -100).isActive = true
                    if self.headlineImage != nil {
                        print("No headline image")
                    }
                case .failure(let error):
                    //                print(error)
                    print("No IMAGE TO SHOW CAN'T FETCH")
                    self.headlineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
                }
                
            }
        }
    }
    
}
