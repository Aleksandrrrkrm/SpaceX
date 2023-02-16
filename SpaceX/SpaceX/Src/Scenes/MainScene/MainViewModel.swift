//
//  MainViewModel.swift
//  SpaceX
//
//  Created by Александр Головин on 15.02.2023.
//

import UIKit
import Moya

protocol MainViewModelProtocol {
    
    var updateViewData: ((Main)->())? { get set }
    func viewDidLoad()
}

final class MainViewModel: MainViewModelProtocol {
    
    public var updateViewData: ((Main) -> ())?
    
    private let provider = MoyaProvider<ApiClient>()
    private var currentPage = 1
    var jsonData: [Main.LaunchModel]?
    
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
                print(statusCode, data.count)
                let launchModel = try? JSONDecoder().decode(Main.LaunchModel.self, from: data)
                print(response.response)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
