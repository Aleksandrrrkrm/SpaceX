//
//  StatusLabel.swift
//  SpaceX
//
//  Created by Александр Головин on 22.02.2023.
//

import UIKit

class StatusLabel: UILabel {

    var isSuccess: Bool = false {
        didSet {
            self.backgroundColor = isSuccess ? .green : .red
            }
        }
    }

