//
//  MainViewController.swift
//  SpaceX
//
//  Created by Александр Головин on 14.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel()
        
        viewModel?.viewDidLoad()
        
        view.backgroundColor = .blue
    }


}

