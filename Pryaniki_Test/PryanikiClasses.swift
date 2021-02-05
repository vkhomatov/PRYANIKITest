//
//  PryanikiClasses.swift
//  Pryaniki_Test
//
//  Created by Vitaly Khomatov on 03.02.2021.
//

import Foundation
import SwiftyJSON


// MARK: - Codable
struct Pryaniki: Codable {
    var data = [Datum]()
    var view = [String]()
}

struct Datum: Codable {
    let name: String
    let data: DataClass
}

struct DataClass: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID = "selectedId"
        case variants
    }
}

struct Variant: Codable {
    let id: Int
    let text: String
}




// MARK: - SwiftyJSON
class Hz {
    var name = String()
    var text = String()
    
    convenience init(from json: JSON) {
        self.init()
        self.name = json["data"][0]["name"].stringValue
        self.text = json["data"][0]["data"]["text"].stringValue
    }
}

class Picture {
    var name = String()
    var url = String()
    var text = String()
    
    convenience init(from json: JSON) {
        self.init()
        self.name = json["data"][1]["name"].stringValue
        self.url = json["data"][1]["data"]["url"].stringValue
        self.text = json["data"][1]["data"]["text"].stringValue
    }
}

class Selector {
    var name = String()
    var selectedId = Int()
    var variants = [Variants]()
    
    convenience init(from json: JSON) {
        self.init()
        self.name = json["data"][2]["name"].stringValue
        self.selectedId = json["data"][2]["data"]["selectedId"].intValue
        let variantsJSON = json["data"][2]["data"]["variants"].arrayValue
        self.variants = variantsJSON.map { Variants(from: $0) }
    }
}

class Variants {
    var id = Int()
    var text = String()
    
    convenience init(from json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.text = json["text"].stringValue
    }
}

class ViewOrder {
   var order = [String]()
    
    convenience init(from json: JSON) {
        self.init()
        self.order = json["view"].arrayValue.map { $0.stringValue }
    }
}


