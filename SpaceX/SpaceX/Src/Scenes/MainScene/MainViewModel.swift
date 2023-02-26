//
//  MainViewModel.swift
//  SpaceX
//
//  Created by Александр Головин on 15.02.2023.
//

import Moya

protocol MainViewModelProtocol {
    
    var updateViewData: ((Main)->())? { get set }
    var data: Main.LaunchModel? { get }
    var jsonData: [Main.LaunchDoc] { get }
    
    func viewDidLoad()
    func getNextPage()
    func goToDetail(_ index: Int)
}

final class MainViewModel: MainViewModelProtocol {
    
    public var coordinator: Coordinator?
    public var updateViewData: ((Main) -> ())?
    public var data: Main.LaunchModel?
    public var jsonData: [Main.LaunchDoc] = []
    
    private let provider = MoyaProvider<ApiClient>()
    
    init() {
        updateViewData?(.initial)
    }
    
    public func viewDidLoad() {
        startFetch(1)
    }
    
    public func getNextPage() {
        guard let currentPage = data?.page,
              let nextPage = data?.nextPage else {
            return
        }
        if currentPage < nextPage {
            startFetch(nextPage)
        }
    }
    
    public func goToDetail(_ index: Int) {
        let currentLaunch = jsonData[index]
        coordinator?.goToDetailPage(currentLaunch)
    }
    
    private func startFetch(_ page: Int) {
        provider.request(.getData(page: page)) { result in
            switch result {
            case let .success(response):
                let data = response.data
                let launchModel = try? JSONDecoder().decode(Main.LaunchModel.self, from: data)
                self.data = launchModel
                guard let docs = launchModel?.docs else {
                    return
                }
                docs.forEach { item in
                    self.jsonData.append(item)
                }
                    self.updateViewData?(.success(self.jsonData))
                
                   
            case let .failure(error):
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        }
    }
}
