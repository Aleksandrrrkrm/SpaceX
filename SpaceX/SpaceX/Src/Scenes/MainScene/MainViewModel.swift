//
//  MainViewModel.swift
//  SpaceX
//
//  Created by Александр Головин on 15.02.2023.
//

import Moya

protocol MainViewModelProtocol {
    
    var updateViewData: ((Main)->())? { get set }
    func viewDidLoad()
}

final class MainViewModel: MainViewModelProtocol {
    
    public var coordinator: Coordinator?
    public var updateViewData: ((Main) -> ())?
    
    private let provider = MoyaProvider<ApiClient>()
    private var currentPage = 1
    private var jsonData: [Main.LaunchDoc] = []
    
    init() {
        updateViewData?(.initial)
    }
    
    public func viewDidLoad() {
        startFetch()
    }
    
    private func startFetch(_ page: Int = 1) {
        provider.request(.getData(page: page)) { result in
            switch result {
            case let .success(response):
                let data = response.data
                let statusCode = response.statusCode
                print(statusCode)
                let launchModel = try? JSONDecoder().decode(Main.LaunchModel.self, from: data)
                guard let docs = launchModel?.docs else {
                    return
                }
                docs.forEach { item in
                    self.jsonData.append(item)
                }
#if DEBUG
                print(self.jsonData.count, self.jsonData.first?.name, self.jsonData.first?.cores?.first?.flight, self.jsonData.first?.success)
#endif
                    self.updateViewData?(.success(self.jsonData))
                
                   
            case let .failure(error):
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        }
    }
}
