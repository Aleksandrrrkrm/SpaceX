//
//  DetailViewModel.swift
//  SpaceX
//
//  Created by Александр Головин on 15.02.2023.
//

import UIKit
import Moya

protocol DetailViewModelProtocol {
    
    var updateViewData: ((Main)->())? { get set }
    var currentCrew: [Main.CrewModel] { get }
    
    func getCrew(_ crew: [String])
}

final class DetailViewModel: DetailViewModelProtocol {
    
    public var coordinator: Coordinator?
    public var updateViewData: ((Main) -> ())?
    
    private let provider = MoyaProvider<ApiClient>()
    
    var currentID: [String] = []
    var allID: [Main.CrewModel] = []
    var currentCrew: [Main.CrewModel] = []
    
    public func getCrew(_ crew: [String]) {
        startFetch()
        crew.forEach { crew in
            self.currentID.append(crew)
        }
    }
    
    private func startFetch() {
        provider.request(.getDetailInfo) { result in
            switch result {
            case let .success(response):
                let data = response.data
                let launchModel = try? JSONDecoder().decode(Main.CrewElementModel.self, from: data)
                guard let crew = launchModel else {
                    return
                }
                crew.forEach { crew in
                    self.allID.append(crew)
                }
                for id in self.allID {
                    print(id.id)
                    for current in self.currentID {
                        print(current)
                        if id.id == current {
                            self.currentCrew.append(id)
                        }
                    }
                }
                self.updateViewData?(.crewSuccess(self.currentCrew))
                   
            case let .failure(error):
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        }
    }
}
