//
//  UniversityViewModel.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/8/22.
//

import UIKit

extension ItemViewModel {
    init(university: University, selection: @escaping () -> Void) {
        title = "\(university.name)"
        subtitle = "Type: \(university.type)"
        select = selection
    }
}

extension UIViewController {
    func select(university: University) {
        let vc = NotImplementedViewController()
        show(vc, sender: self)
    }
}
