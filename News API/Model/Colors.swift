//
//  Colors.swift
//  News API
//
//  Created by Cao Mai on 5/4/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

let category = ["General", "Business", "Science", "Technology", "Health", "Entertainment", "Sports"]
let uiColors = [#colorLiteral(red: 0.1176470588, green: 0.6980392157, blue: 0.6509803922, alpha: 1), #colorLiteral(red: 0.831372549, green: 0.9725490196, blue: 0.9098039216, alpha: 1), #colorLiteral(red: 1, green: 0.6392156863, blue: 0.3019607843, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.8492380977, green: 0, blue: 0.3497368693, alpha: 1)]

enum ProjectColor {
    case generalColor
    case businessColor
    case scienceColor
    case techColor
    case healthColor
    case entertainColor
    case sportsColor
}
extension ProjectColor: RawRepresentable {
    typealias RawValue = UIColor
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case #colorLiteral(red: 0.1176470588, green: 0.6980392157, blue: 0.6509803922, alpha: 1): self = .generalColor
        case #colorLiteral(red: 0.831372549, green: 0.9725490196, blue: 0.9098039216, alpha: 1): self = .businessColor
        case #colorLiteral(red: 1, green: 0.6392156863, blue: 0.3019607843, alpha: 1): self = .scienceColor
        case #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1): self = .techColor
        case #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1): self = .healthColor
        case #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1): self = .entertainColor
        case #colorLiteral(red: 0.8492380977, green: 0, blue: 0.3497368693, alpha: 1): self = .sportsColor
            
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .generalColor: return #colorLiteral(red: 0.1176470588, green: 0.6980392157, blue: 0.6509803922, alpha: 1)
        case .businessColor: return #colorLiteral(red: 0.831372549, green: 0.9725490196, blue: 0.9098039216, alpha: 1)
        case .scienceColor: return #colorLiteral(red: 1, green: 0.6392156863, blue: 0.3019607843, alpha: 1)
        case .techColor: return #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        case .healthColor: return #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        case .entertainColor: return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case .sportsColor: return #colorLiteral(red: 0.8492380977, green: 0, blue: 0.3497368693, alpha: 1)
            
        }
    }
}
