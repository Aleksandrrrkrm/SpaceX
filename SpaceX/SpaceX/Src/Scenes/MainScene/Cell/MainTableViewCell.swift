//
//  MainTableViewCell.swift
//  SpaceX
//
//  Created by Александр Головин on 20.02.2023.
//

import UIKit
import Stevia

class MainTableViewCell: UITableViewCell {
    
    let iconView = UIImageView()
    let nameTitle = UILabel()
    let flightTitle = UILabel()
    let statusTitle = UILabel()
    let dateTitle = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView() {
        contentView.subviews(iconView,
                       nameTitle,
                       flightTitle,
                       statusTitle,
                       dateTitle)
        
    }

    func setupImage(_ data: Main.LaunchDoc) {
        nameTitle.text = data.name
//        flightTitle.text = data.cores?.first?.flight
        statusTitle.text = data.success ?? false ? "Success" : "Fail"
        dateTitle.text = data.date_utc
        print(nameTitle.text)
    }
}
