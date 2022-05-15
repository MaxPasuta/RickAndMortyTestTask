//
//  ModuleBuilder.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 12.05.2022.
//

import UIKit

protocol AsselderBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(router: RouterProtocol, person: Result?) -> UIViewController
}

class AsselderModelBuilder: AsselderBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkDataFetch()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(router: RouterProtocol, person: Result?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkDataFetch()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, person: person)
        view.presenter = presenter
        return view
    }
}

