//
//  NetworkDataFetch.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 14.04.2022.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    public let firstPage = "https://rickandmortyapi.com/api/character/?page=1"
    
    public func fetch20Persons(urlString: String, responce: @escaping(PersonsModel?, Error?) -> Void){
        
        NetworkRequest.shated.requestData(urlString: urlString) { result in
            
            switch result {
            case .success(let data):
                do {
                    let data = try JSONDecoder().decode(PersonsModel.self, from: data)
                    responce(data, nil)
                    
                } catch let jsonerror{
                    print("Failed to decode JSON: \(jsonerror.localizedDescription)")
                }
                
            case .failure(let error):
                print("Error received reuestiing data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
    
    public func fetchDetailPerson(id: Int, responce: @escaping(PersonDetailModel?, Error?) -> Void){

        let urlString = "https://rickandmortyapi.com/api/character/\(id)"
        
        NetworkRequest.shated.requestData(urlString: urlString) { result in
            
            switch result {
            case .success(let data):
                do {
                    let data = try JSONDecoder().decode(PersonDetailModel.self, from: data)
                    responce(data, nil)
                    
                } catch let jsonerror{
                    print("Failed to decode JSON: \(jsonerror.localizedDescription)")
                }
                
            case .failure(let error):
                print("Error received reuestiing data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
