//
//  FileserviceAlamofire.swift
//  Pryaniki_Test
//
//  Created by Vitaly Khomatov on 03.02.2021.
//

import Alamofire
import Foundation
import SwiftyJSON

class FileserviceAF {
    
    
    func getCodableJsonAF(completion: @escaping (Swift.Result<Pryaniki, Error>) -> Void) {
        
        AF.request("https://pryaniky.com/static/json/sample.json").responseData { responce in
            
            switch responce.result {
            
            case let .success(data):
                if let pryaniki = try? JSONDecoder().decode(Pryaniki.self, from: data) {
                    completion(.success(pryaniki))
                }
            case let .failure(error):
                print("\ngetCodableJsonAF: ошибка при загрузке данных - \(error)")
                
            }
        }
        
    }
    
    
    func getSwiftyJsonAF(completion:  @escaping (Swift.Result<(Hz, Picture, Selector, ViewOrder), Error>) -> Void) {
        
        AF.request("https://pryaniky.com/static/json/sample.json").responseData { responce in
            
            switch responce.result {
            
            case let .success(data):
                let json = JSON(data)
                let data1 = Hz(from: json)
                let data2 = Picture(from: json)
                let data3 = Selector(from: json)
                let data4 = ViewOrder(from: json)
                completion(.success((data1, data2, data3, data4)))
                
            case let .failure(error):
                print("\ngetSwiftyJsonAF: ошибка при загрузке данных - \(error)")
                
            }
            
        }
        
    }
    
    
}
