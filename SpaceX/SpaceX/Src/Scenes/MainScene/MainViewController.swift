//
//  MainViewController.swift
//  SpaceX
//
//  Created by Александр Головин on 14.02.2023.
//

import UIKit
import Stevia

class MainViewController: UIViewController {
    
    var tableView = UITableView()
    var viewData: [Main.LaunchDoc] = []
    var viewModel: MainViewModelProtocol?
    var activityIndicator = UIActivityIndicatorView()
    var dialogMessage = UIAlertController(title: "Error", message: "Check your internet connection.", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDidLoad()
        
        updateView()
        setupTableView()
        configureAlert()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "SpaceX"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = ""
    }
    
    private func setupTableView() {
        view.subviews(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "mainCell")
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
        
        view.layout(
        0,
        |-0-tableView-0-|,
        0
        )
    }
    
    private func configureAlert() {
        let ok = UIAlertAction(title: "OK", style: .default)
        dialogMessage.addAction(ok)
    }
    
    private func updateView() {
        viewModel?.updateViewData = { [weak self] viewData in
            guard let view = self else {
                return
            }
            switch viewData {
            case .success(let data):
                view.activityIndicator.stopAnimating()
                guard let data = data else {
                    return
                }
                data.forEach { data in
                    view.viewData.append(data)
                }
                self?.tableView.reloadData()
            case .failure:
                view.present(view.dialogMessage, animated: true, completion: nil)
                view.activityIndicator.stopAnimating()
                break
            case .crewSuccess(_):
                break
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height/2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.jsonData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        guard let data = viewModel?.jsonData else {
            return cell
        }
        cell.setupCell(data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let data = viewModel?.jsonData else {
            return
        }
        
        if indexPath.row == data.count - 1 {
            viewModel?.getNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.goToDetail(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

