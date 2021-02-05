//
//  PryanikiNewViewModel.swift
//  Pryaniki_Test
//
//  Created by Vitaly Khomatov on 04.02.2021.
//

import UIKit

class PryanikiNewViewModel {
    
    private let fileserviceAF = FileserviceAF()
    var pryaniki = Pryaniki()
    var newPryaniki = [Datum]()

    
    func loadCodableData(completion: @escaping () -> ()) {
        
        fileserviceAF.getCodableJsonAF() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(pryaniki):
                self.pryaniki = pryaniki
                print("getCodableJsonAF() данные успешно загружены")
                completion()
            case .failure(_):
                print("getCodableJsonAF() не удалось загрузить данные")
            }
        }
        
    }
    
    
    func pryanikiAdapter(pryaniki: Pryaniki) {
        
        for element in pryaniki.view {
            for pryanik in pryaniki.data {
                if pryanik.name == element {
                    newPryaniki.append(pryanik)
                }
            }
        }
        
    }
    
    
}





