//
//  ItemViewModel.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/6/22.
//

import UIKit

enum Items {
    case school(School)
    case university(University)
}

public struct ItemViewModel {
    let title: String
    let subtitle: String
    let select: () -> Void
    
    init(item: Items, select: @escaping () -> Void) {
        
        switch item {
        case .school(let school):
            self.init(school: school, selection: select)
        case .university(let university):
            self.init(university: university, selection: select)
        }
    }
}
