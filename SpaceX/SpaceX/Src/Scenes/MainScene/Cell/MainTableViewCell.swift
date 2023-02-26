//
//  MainTableViewCell.swift
//  SpaceX
//
//  Created by Александр Головин on 20.02.2023.
//

import UIKit
import Stevia

class MainTableViewCell: UITableViewCell {
    
    var baseView = UIView()
    var iconView = ImageLoader()
    var descriptionView = UIView()
    var nameTitle = UILabel()
    var flightTitle = UILabel()
    var statusTitle = StatusLabel()
    var dateTitle = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconView.image = nil
    }
    
    func configureView() {
        contentView.subviews(baseView.subviews(iconView,
                                               statusTitle,
                                               descriptionView.subviews(nameTitle,
                                                                        flightTitle,
                                                                        dateTitle)))
        
        contentView.layout(
            16,
            |-16-baseView-16-|,
            0
        )
        
        baseView.layout(
            6,
            statusTitle-8-|
        )
        
        baseView.layout(
            16,
            |-16-iconView-16-| ~ contentView.bounds.height/1.6,
            16,
            |-0-descriptionView-0-|,
            0
        )
        
        descriptionView.layout(
            8,
            |-12-nameTitle-12-|,
            8,
            |-12-dateTitle-flightTitle-12-|,
            16
        )
        
        descriptionView.style { view in
            view.backgroundColor = UIColor(named: "appMainBlue")
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = .zero
            view.layer.shadowRadius = 8
        }
        
        baseView.style { view in
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.gray.cgColor
            view.layer.cornerRadius = 14
            view.clipsToBounds = true
        }
        
        nameTitle.style { label in
            label.textAlignment = .center
            label.backgroundColor = .clear
            label.textColor = .white
            label.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
            
            label.layer.shadowColor = UIColor.white.cgColor
            label.layer.shadowOpacity = 1
            label.layer.shadowOffset = .zero
            label.layer.shadowRadius = 2
        }
        
        flightTitle.style { label in
            label.textAlignment = .right
            label.textColor = .white
            
            label.layer.shadowColor = UIColor.white.cgColor
            label.layer.shadowOpacity = 1
            label.layer.shadowOffset = .zero
            label.layer.shadowRadius = 2
        }
        
        statusTitle.style { label in
            label.textAlignment = .center
            label.clipsToBounds = true
            label.layer.cornerRadius = 8
            label.width(90)
        }
        
        dateTitle.style { label in
            label.textAlignment = .left
            label.backgroundColor = .clear
            label.textColor = .white
            
            label.layer.shadowColor = UIColor.white.cgColor
            label.layer.shadowOpacity = 1
            label.layer.shadowOffset = .zero
            label.layer.shadowRadius = 2
        }
        
        iconView.style { image in
            image.layer.cornerRadius = 8
            image.clipsToBounds = true
        }
    }
        
        func setupCell(_ data: Main.LaunchDoc) {
            nameTitle.text = data.name
            statusTitle.isSuccess = data.success ?? false
            statusTitle.text = data.success ?? false ? "Success" : "Fail"
            
            
            dateTitle.text = data.date_utc
            if let url = URL(string: data.links?.patch?.small ?? "") {
                iconView.loadImageWithUrl(url)
            } else {
                iconView.image = UIImage(named: "placeholder")
            }
            
            if let flights = data.cores?.first?.flight {
                flightTitle.text = String(flights)
            } else {
                flightTitle.text = "0"
            }
        }
    }

