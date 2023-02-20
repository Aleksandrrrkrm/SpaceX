//
//  MainViewController.swift
//  SpaceX
//
//  Created by Александр Головин on 14.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var tableView = UITableView()
    
    var viewData: [Main.LaunchDoc] = []
    
    var viewModel: MainViewModelProtocol?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .blue
        
        updateView()
        setupTableView()
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
                self?.viewData = data
                self?.tableView.reloadData()
#if DEBUG
                print(self?.viewData.first?.name ?? "errorMainVC")
#endif
            case .initial:
                break
            case .failure( _):
                break
            case .loading( _):
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
        viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(self.viewData[indexPath.row])
        return cell
        
    }
}

