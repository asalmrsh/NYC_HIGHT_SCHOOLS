//
//  SchoolViewModel.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/6/22.
//

import UIKit

extension ItemViewModel {
    init(school: School, selection: @escaping () -> Void) {
        title = "\(school.name)"
        subtitle = "Neighborhood: \(school.neighborhood)"
        select = selection
    }
}

extension UIViewController {
    func select(school: School) {
        let vc = DetailedViewController()
        vc.school = school
        vc.service = SchoolDetailAdapter(schoolAPI: SchoolAPI.shard)
        show(vc, sender: self)
    }
}
