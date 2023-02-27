//
//  DetailViewController.swift
//  SpaceX
//
//  Created by Александр Головин on 15.02.2023.
//

import UIKit
import Stevia

class DetailViewController: UIViewController {

    var detailModel: DetailViewModelProtocol?
    
    var viewForScroll = UIView()
    var scrollView = UIScrollView()
    var contentView = UIView()
    var lowView = UIView()
    var imageView = UIView()
    var iconView = ImageLoader()
    var descriptionView = UIView()
    var nameLabel = UILabel()
    var statusLabel = StatusLabel()
    var dateTitle = UILabel()
    var dateLabel = UILabel()
    var flightTitle = UILabel()
    var flightLabel = UILabel()
    var detailsLabel = UILabel()
    var crewView = UILabel()
    var tableView = UITableView()
    var crewTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        configureAperiance()
        updateView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "detailCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavController()
    }
    
    private func updateView() {
        detailModel?.updateViewData = { [weak self] viewData in
            switch viewData {
            case .success:
                break
            case .failure:
                break
            case .crewSuccess(_):
                self?.crewTitle.isHidden = false
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
                self?.view.setNeedsLayout()
            }
        }
    }
    
    private func setupNavController() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    func setData(_ data: Main.LaunchDoc) {
        if !(data.crew?.isEmpty ?? true) {
            guard let crew = data.crew else {
                return
            }
            detailModel?.getCrew(crew)
        }
        detailsLabel.text = data.details
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = DateFormats.spaceXLaunch
        if let date = dateFormatter.date(from: data.date_utc ?? "") {
            let compactDateFormatter = DateFormatter()
            compactDateFormatter.locale = Locale.current
            compactDateFormatter.dateFormat = DateFormats.spaceXRocketFirstLaunch
            dateLabel.text = compactDateFormatter.string(from: date)
        }
        
        nameLabel.text = data.name
        statusLabel.text = data.success ?? false ? "Success" : "Fail"
        statusLabel.isSuccess = data.success ?? false
        if let url = URL(string: data.links?.patch?.small ?? "") {
            iconView.loadImageWithUrl(url)
        }
        if let flights = data.cores?.first?.flight {
            flightLabel.text = String(flights)
        } else {
            flightLabel.text = "0"
        }
    }
    
    private func setupViews() {
        addViews()
        baseView()
        setLowView()
        setupDescriptionView()
        setupIconView()
        setupScrollView()
        setupDetails()
        setupTableView()
    }
    
    private func addViews() {
        view.subviews(imageView.subviews(statusLabel,
                                         iconView),
                      lowView,
                      descriptionView.subviews(nameLabel,
                                               viewForScroll.subviews(scrollView.subviews(contentView.subviews(detailsLabel,
                                                             dateLabel,
                                                             dateTitle,
                                                             flightTitle,
                                                             flightLabel,
                                                             crewTitle,
                                                             crewView.subviews(tableView))))
                      ))
    }
    
    private func setupScrollView() {
        viewForScroll.layout(
            0,
            scrollView.centerHorizontally().width(view.bounds.width),
            0
        )
        
        scrollView.layout(
            0,
            contentView.centerHorizontally().width(view.bounds.width),
            0
        )
    }
    
    private func setupDetails() {
        contentView.layout(
        20,
        |-24-detailsLabel-24-|,
        20,
        |-24-dateTitle-dateLabel-24-|,
        20,
        |-24-flightTitle-flightLabel-24-|,
        10,
        |-crewTitle-|,
        10,
        |-2-crewView-2-|,
        0
        )
    }
    
    private func setupTableView() {
        crewView.layout(
        0,
        |-0-tableView-0-| ~ 600,
        0
        )
    }
    
    private func baseView() {
       
       imageView.Height == 40 % view.Height

       view.layout (
           0,
           |-0-imageView-0-|,
           -20,
           |-0-descriptionView-0-|,
           0
       )
    }
    
    private func setupIconView() {
        iconView.centerHorizontally()
        iconView.centerVertically(offset: 20)
        iconView.Width == 65 % view.Width
        iconView.Height ==  iconView.Width
        
        statusLabel.Top == iconView.Top
        imageView.layout(
            statusLabel-|
        )
    }
    
    private func setupDescriptionView() {
        descriptionView.layout (
        16,
        |-nameLabel-| ~ 40,
        0,
        |-0-viewForScroll-0-|,
        0
        )
    }
    
    
    private func setLowView() {
        view.layout(
        |-0-lowView-0-| ~ 40,
        0
        )
    }
    
    private func configureAperiance() {
        view.backgroundColor = UIColor(named: "appMainBlue")
        
        detailsLabel.textColor = .white
        detailsLabel.font = UIFont(name:"HelveticaNeue", size: 18)
        detailsLabel.numberOfLines = 0
        
        descriptionView.backgroundColor = .black
        descriptionView.layer.cornerRadius = 40
        
        iconView.backgroundColor = .clear
        imageView.backgroundColor = .clear
        nameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 24)
        flightLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        lowView.backgroundColor = .black
        viewForScroll.backgroundColor = .clear
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        statusLabel.style { label in
            label.textAlignment = .center
            label.clipsToBounds = true
            label.layer.cornerRadius = 8
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.black.cgColor
            label.width(90)
        }
        
        flightTitle.text = "Reuses of the first stage"
        flightTitle.textAlignment = .left
        flightTitle.font = UIFont(name:"HelveticaNeue", size: 16)
        flightTitle.textColor = .white
        
        flightLabel.textAlignment = .right
        flightLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16)
        flightLabel.textColor = .white
        
        dateTitle.text = "Launch date"
        dateTitle.textAlignment = .left
        dateTitle.font = UIFont(name:"HelveticaNeue", size: 16)
        dateTitle.textColor = .white
        
        dateLabel.textAlignment = .right
        dateLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16)
        dateLabel.textColor = .white
        
        crewTitle.isHidden = true
        crewTitle.textAlignment = .center
        crewTitle.text = "Crew"
        crewTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        crewTitle.textColor = .white
        
        tableView.isHidden = true
        tableView.backgroundColor = .black
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height/7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailModel?.currentCrew.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        guard let data = detailModel?.currentCrew else {
            return UITableViewCell()
        }
        cell.setupCell(data[indexPath.row])
        return cell
    }
}
