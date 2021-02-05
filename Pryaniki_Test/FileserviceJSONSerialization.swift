//
//  FileserviceJSONSerialization.swift
//  Pryaniki_Test
//
//  Created by Vitaly Khomatov on 03.02.2021.
//

import Foundation

// не используется, сделал для демогстрации
final class Fileservice {
    
    let configurations = URLSessionConfiguration.default
    let session = URLSession.shared
    var urlConstructor = URLComponents()
    
    func getJson() {
        urlConstructor.scheme = "https"
        urlConstructor.host = "pryaniky.com"
        urlConstructor.path = "/static/json/sample.json"
        
        if let url = urlConstructor.url {
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) {
                  print(json as Any)
                } else {
                  print(error as Any)
                }
            }
            task.resume()
        }
        
      
    }
    
}
