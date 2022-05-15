//
//  MainPresenter.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 10.05.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkDataFetch, router: RouterProtocol)
    func infiniteScroll()
    func tapOnThePerson(person: Result?)
    var persons: [Result]? {get set}
    var nextPage: String? {get}
    
}

class MainPresenter: MainViewPresenterProtocol{

    weak var view: MainViewProtocol?
    let networkService: NetworkDataFetchProtocol!
    var router: RouterProtocol?
    var persons: [Result]? = []
    var nextPage: String?
    
    required init(view: MainViewProtocol, networkService: NetworkDataFetch, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.nextPage = networkService.firtsPage
        self.router = router
    }
    
    func tapOnThePerson(person: Result?) {
        router?.showDetail(person: person)
    }
    
    func infiniteScroll() {
        guard let nextPage = nextPage else {
            return
        }

        networkService.fetch20Persons(urlString: nextPage) {[weak self] persons, error in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                if error == nil{
                    guard let persons = persons else {return}
                    self.persons?.append(contentsOf: persons.results)
                    self.nextPage = persons.info.next
                    self.view?.succes()
                }
                else {
                    print(error!.localizedDescription)
                    self.view?.failure(error: error!)
                }
            }
        }
    }
}
