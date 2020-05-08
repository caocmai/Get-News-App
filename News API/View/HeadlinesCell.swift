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
//        headlineImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        headlineImage.widthAnchor.constraint(equalTo: headlineImage.heightAnchor, multiplier: 12/9).isActive = true

        
        
        if let safeTitle = article.title {
           
            let str = safeTitle.components(separatedBy: " - ")[0]
            headlineLabel.text = str
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
                    self.headlineLabel.trailingAnchor.constraint(equalTo: self.headlineImage.leadingAnchor, constant: -5).isActive = true
                    self.headlineImage.image = value.image

                    if self.headlineImage != nil {
                        print("No headline image")
//                        self.headlineLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true

                    }
                case .failure(let error):
                    //                print(error)
                    print("No IMAGE TO SHOW CAN'T FETCH")
                    self.headlineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
                }
                
            }
        }
    }
    
}
