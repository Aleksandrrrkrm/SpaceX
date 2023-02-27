//
//  MainTableViewCell.swift
//  SpaceX
//
//  Created by Александр Головин on 20.02.2023.
//

import UIKit
import Stevia

final class MainTableViewCell: UITableViewCell {
    
    // MARK: - Properties
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
        
        configureLayout()
        configureApperiance()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconView.image = nil
    }
    
    // MARK: - UIView
    private  func configureLayout() {
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
    }

    private func configureApperiance() {
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
            label.font = UIFont(name: AppFont.bold.rawValue, size: 20)
            
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
    
    // MARK: - Setup Cell
    public func setupCell(_ data: Main.LaunchDoc) {
        nameTitle.text = data.name
        statusTitle.isSuccess = data.success ?? false
        statusTitle.text = data.success ?? false ? Status.success.rawValue : Status.fail.rawValue
    
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = DateFormats.spaceXLaunch
        if let date = dateFormatter.date(from: data.date_utc ?? "") {
            let compactDateFormatter = DateFormatter()
            compactDateFormatter.locale = Locale.current
            compactDateFormatter.dateFormat = DateFormats.displayDateFormat
            dateTitle.text = compactDateFormatter.string(from: date)
        }
        
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

