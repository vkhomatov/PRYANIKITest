//
//  PryanikiViewModel.swift
//  Pryaniki_Test
//
//  Created by Vitaly Khomatov on 05.02.2021.
//

import UIKit

class PryanikiViewModel {
    
    let fileserviceAF = FileserviceAF()
    var hz = Hz()
    var picture = Picture()
    var selector = Selector()
    var order = ViewOrder()
    
    func loadSwiftyJSONData(completion: @escaping () -> Void) {
        
        fileserviceAF.getSwiftyJsonAF() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success((data1, data2, data3, data4)):
                self.hz = data1
                self.picture = data2
                self.selector = data3
                self.order = data4
                print("getSwiftyJsonAF() данные успешно загружены")
                completion()
                
            case .failure(_):
                print("getSwiftyJsonAF() не удалось загрузить данные")
                
            }
        }
        
    }
    

    func getDeviceModel() -> CGFloat {
        
        let deviceModel = UIDevice.current.name
        if deviceModel.contains("X") || deviceModel.contains("11") || deviceModel.contains("12")  {
            return 70
        } else {
            return 50
        }
        
    }
    
}
