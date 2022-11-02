//
//  DataProvider.swift
//  Places
//
//  Created by Андрей Парчуков on 02.11.2022.
//

import Foundation

enum DataProviderError: Error {
    case dataFileNotFound
    case dataLoadError
    case parsingError
}

class DataProvider {
    
    static let shared = DataProvider()
    
    private init() {}
    
    func load<T: Decodable>(
        _ type: T.Type,
        _ filename: String,
        completion: @escaping (Result<T, DataProviderError>) -> Void
    ) {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            completion(.failure(.dataFileNotFound))
            return
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            completion(.failure(.dataLoadError))
            return
        }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.parsingError))
        }
    }
}
