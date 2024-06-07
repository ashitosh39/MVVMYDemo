//
//  APIManger.swift
//  MVVMYogeshPatel
//
//  Created by Macintosh on 23/04/24.
//

import Foundation
enum DataError: Error {
case invalidResponse
    case invalidURL
    case invalidData
    case network (Error?)
    
}
typealias Handler = ((Result<[Product],DataError>)->Void)


final class APIManager {
    static let sheard = APIManager()
    private init(){}
    
    func fetchProducts(compilation : @escaping Handler){
        guard let url = URL(string: Constant.API.productUrl) else{
            compilation(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url){data, response, error in
            guard let data = data else {
                compilation(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
            200...299 ~= response.statusCode else {
                compilation(.failure(.invalidResponse))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                compilation(.success(products))
            }catch{
                    compilation(.failure(.network(error)))
            }
        }.resume()

        }
}
        
    



