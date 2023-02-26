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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        updateView()
        setupTableView()
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
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "mainCell")
    }
    
    private func updateView() {
        viewModel?.updateViewData = { [weak self] viewData in
            switch viewData {
            case .success(let data):
                
                guard let data = data else {
                    return
                }
                data.forEach { data in
                    self?.viewData.append(data)
                }
                self?.tableView.reloadData()
            case .initial:
                break
            case .failure( _):
                break
            case .loading( _):
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

