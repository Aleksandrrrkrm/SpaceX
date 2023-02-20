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
        configureView()
    }
    
    func configureView() {
        contentView.subviews(iconView,
                       nameTitle,
                       flightTitle,
                       statusTitle,
                       dateTitle)
        layout(
            100,
            |-nameTitle-| ~ 80,
            8,
            |-statusTitle-| ~ 80,
            "",
            |dateTitle| ~ 80,
            0
        )
        
    }

    func setupCell(_ data: Main.LaunchDoc) {
        nameTitle.text = data.name
        statusTitle.text = data.success ?? false ? "Success" : "Fail"
        dateTitle.text = data.date_utc
#if DEBUG
        print(nameTitle.text)
#endif
    }
}
