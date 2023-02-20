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
}

class BaseCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
#if DEBUG
        print("start")
#endif
        goToMainPage()
    }
    
    func goToMainPage(){
        let mainViewController = MainViewController()
        let mainViewModel = MainViewModel()
        mainViewModel.coordinator = self
        mainViewController.viewModel = mainViewModel
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func goToDetailPage(){
        let detailViewController = DetailViewController()
        let detailViewModel = DetailViewModel.init()
        detailViewModel.coordinator = self
        detailViewController.detailModel = detailViewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
