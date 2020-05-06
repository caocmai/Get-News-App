//
//  Colors.swift
//  News API
//
//  Created by Cao Mai on 5/4/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

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
        case #colorLiteral(red: 0.7960784314, green: 0.8862745098, blue: 0.6901960784, alpha: 1): self = .businessColor
        case #colorLiteral(red: 1, green: 0.6392156863, blue: 0.3019607843, alpha: 1): self = .scienceColor
        case #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1): self = .techColor
        case #colorLiteral(red: 1, green: 0.9215686275, blue: 0.6, alpha: 1): self = .healthColor
        case #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1): self = .entertainColor
        case #colorLiteral(red: 0.8677538037, green: 0.002994516632, blue: 0.3618242145, alpha: 0.8883775685): self = .sportsColor
            
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .generalColor: return #colorLiteral(red: 0.1176470588, green: 0.6980392157, blue: 0.6509803922, alpha: 1)
        case .businessColor: return #colorLiteral(red: 0.7960784314, green: 0.8862745098, blue: 0.6901960784, alpha: 1)
        case .scienceColor: return #colorLiteral(red: 1, green: 0.6392156863, blue: 0.3019607843, alpha: 1)
        case .techColor: return #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        case .healthColor: return #colorLiteral(red: 1, green: 0.9215686275, blue: 0.6, alpha: 1)
        case .entertainColor: return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case .sportsColor: return #colorLiteral(red: 0.8677538037, green: 0.002994516632, blue: 0.3618242145, alpha: 0.8883775685)
            
        }
    }
}
