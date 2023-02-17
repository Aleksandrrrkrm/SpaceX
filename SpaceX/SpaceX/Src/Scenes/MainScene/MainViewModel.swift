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
    var jsonData: [LaunchDoc] = []
    
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
                let launchModel = try? JSONDecoder().decode(LaunchModel.self, from: data)
                guard let docs = launchModel?.docs else {
                    return
                }
                docs.forEach { item in
                    self.jsonData.append(item)
                }
                print(self.jsonData.count, self.jsonData.first?.name, self.jsonData.first?.cores?.first?.flight, self.jsonData.first?.success)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
