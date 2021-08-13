//
//  RequestLayer.swift
//  Task
//
//  Created by Mac on 12/08/2021.
//

import Foundation
import Combine

class RequestLayer {
    // MARK: - convert T generics to Product model 
    static func ReadJsonFile()-> Future<Product,RequestError>{
        let readerManager = ReaderManager.shared
        readerManager.fileName = FileName
        readerManager.extenstion = FileExtension
        return readerManager.parseJson()
    }
}
