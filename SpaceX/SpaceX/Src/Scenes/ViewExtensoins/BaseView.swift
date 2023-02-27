//
//  BaseView.swift
//  SpaceX
//
//  Created by Александр Головин on 27.02.2023.
//

import Stevia

enum LabelStyle {
    case low
    case medium
    case bold
}

class BaseView: UIViewController {
    
    func setupLabel(_ label: UILabel, _ style: LabelStyle) {
            switch style {
            case .low:
                label.style { label in
                    label.font = UIFont(name:"HelveticaNeue", size: 16)
                    label.textColor = .white
                }
            case .medium:
                label.style { label in
                    label.textColor = .white
                    label.font = UIFont(name:"HelveticaNeue", size: 18)
                }
            case .bold:
                label.style { label in
                    label.font = UIFont(name:"HelveticaNeue-Bold", size: 16)
                    label.textColor = .white
                }
            }
        
    }
}
