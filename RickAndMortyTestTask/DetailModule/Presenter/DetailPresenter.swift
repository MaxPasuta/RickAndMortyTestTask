//
//  DetailPresenter.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 14.05.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkDataFetch, router: RouterProtocol, person: Result?)
    func getDetailPerson(id: Int)
    var personDetail: PersonDetail? {get set}
    var person: Result? {get}
}

class DetailPresenter: DetailViewPresenterProtocol{
    
    var personDetail: PersonDetail?
    weak var view: DetailViewProtocol?
    let networkService: NetworkDataFetchProtocol!
    var router: RouterProtocol?
    var person: Result?
   
    required init(view: DetailViewProtocol, networkService: NetworkDataFetch, router: RouterProtocol, person: Result?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.person = person
        
        guard let person = person else {return}
        getDetailPerson(id: person.id)
    }
    
    func getDetailPerson(id: Int) {
        networkService.fetchDetailPerson(id: id) { personDetail, error in
            DispatchQueue.main.async {
                if error == nil{
                    guard let personDetail = personDetail else {return}
                    self.personDetail = personDetail
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

