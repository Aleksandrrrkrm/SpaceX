//
//  BaseCoordinator.swift
//  SpaceX
//
//  Created by Александр Головин on 19.02.2023.
//

import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    
    func start()
    func goToDetailPage(_ data: Main.LaunchDoc)
}

class BaseCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        goToMainPage()
    }
    
    func goToMainPage() {
        let mainViewController = MainViewController()
        let mainViewModel = MainViewModel()
        mainViewModel.coordinator = self
        mainViewController.viewModel = mainViewModel
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func goToDetailPage(_ data: Main.LaunchDoc) {
        let detailViewController = DetailViewController()
        let detailViewModel = DetailViewModel.init()
        detailViewModel.coordinator = self
        detailViewController.detailModel = detailViewModel
        detailViewController.setData(data)
        navigationController.pushViewController(detailViewController, animated: true)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
    }
}
