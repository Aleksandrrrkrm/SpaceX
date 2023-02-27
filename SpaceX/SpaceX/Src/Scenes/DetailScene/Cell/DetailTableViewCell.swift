//
//  DetailTableViewCell.swift
//  SpaceX
//
//  Created by Александр Головин on 26.02.2023.
//

import UIKit
import Stevia

class DetailTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var iconView = ImageLoader()
    var fullNameLabel = UILabel()
    var agencyLabel = UILabel()
    var statusLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        contentView.backgroundColor = .black
        setupView()
        configureLayout()
        configureApperiance()
    }
    
    // MARK: - Setup Cell
    func setupCell(_ data: Main.CrewModel) {
        if let url = URL(string: data.image) {
            iconView.loadImageWithUrl(url)
        } else {
            iconView.image = UIImage(named: "placeholder")
        }
        fullNameLabel.text = data.name
        agencyLabel.text = data.agency
        switch data.status {
        case .active:
            self.statusLabel.text = "Active"
        }
    }

    // MARK: - UIView
    private func setupView() {
        contentView.subviews(iconView,
                             fullNameLabel,
                             agencyLabel,
                             statusLabel)
    }
    
    private func configureLayout() {
        contentView.layout(
        12,
        |-12-iconView.width(contentView.bounds.height - 24),
        12
        )
        
        contentView.layout(
        12,
        fullNameLabel-|,
        2,
        statusLabel-|,
        2,
        agencyLabel-|
        )
    }
    
    private func configureApperiance() {
        iconView.style { icon in
            icon.contentMode = .scaleToFill
            icon.layer.cornerRadius = 7
            icon.clipsToBounds = true
        }
        
        fullNameLabel.style { label in
            label.textAlignment = .right
            label.font = UIFont(name:"HelveticaNeue-Bold", size: 14)
            label.textColor = .white
        }
        
        statusLabel.style { label in
            label.textAlignment = .right
            label.font = UIFont(name:"HelveticaNeue-Bold", size: 14)
            label.textColor = .white
        }
        
        agencyLabel.style { label in
            label.textAlignment = .right
            label.font = UIFont(name:"HelveticaNeue-Bold", size: 14)
            label.textColor = .white
        }
    }
}
