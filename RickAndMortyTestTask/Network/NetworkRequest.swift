//
//  NetworkRequest.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 14.04.2022.
//

import Foundation

class NetworkRequest{
    
    static let shated = NetworkRequest()
    
    private init() {}
    
    func requestData(urlString: String, completion: @escaping (Swift.Result<Data, Error>) -> Void){
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                completion(.success(data))
            }
        }.resume()
    }
}
