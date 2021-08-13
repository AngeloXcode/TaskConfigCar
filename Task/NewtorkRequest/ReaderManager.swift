//
//  LocalJsonViewModel.swift
//  Task
//
//  Created by Mac on 13/08/2021.
//

import Foundation
import Combine
import UIKit
// MARK: Enumeration for any error when read file
enum RequestError : Error {
    case invalidFile
    case notFoundFile
    case dataLoadingError
    case jsonDecodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidFile:
            return InvalidFile
        case .notFoundFile:
            return NotFoundFile
        case .jsonDecodingError:
            return DecodingError
        case .dataLoadingError:
            return LoadingError
        }
    }
}
// MARK: Singleton class to read json file
class ReaderManager {
    // MARK: - Properties
    var fileName : String? // json file Name
    var extenstion : String? // extesntion for file Name
    static let shared = ReaderManager()
    init() {
    }
    // MARK: - reading json file and using Future and return any type of model using generics Decodable and handle error with RequestError Enumeration RequestError
    func parseJson<T:Decodable>() ->Future<T,RequestError> {
        return Future<T,RequestError> { promise in
            if let file = self.fileName , let ext = self.extenstion {
                // read file
                if let  path = Bundle.main.path(forResource:file, ofType:ext){
                    let url = URL(fileURLWithPath:path)
                    do{
                        // parse file from data to Json using JSONDecoder
                        let data   = try Data(contentsOf: url)
                        let result = try JSONDecoder().decode(T.self, from: data)
                        promise(.success(result)) // return data when success
                    }catch{
                        promise(.failure(.invalidFile)) // return error and message error
                    }
                }else{
                    promise(.failure(.notFoundFile)) // return error and message error 
                }
            }
        }
    }
}
