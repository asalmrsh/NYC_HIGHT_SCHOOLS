//
//  UniversityAPI.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/8/22.
//

import Foundation

class UniversityAPI {
    static var shard = UniversityAPI()
    
    func loadUniversities(completion: @escaping (Result<[University], AppError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.75) {
            completion(.success([
                University(name: "Adelphi University", type: "public"),
                University(name: "Albany College of Pharmacy and Health Sciences", type: "public"),
                University(name: "American Musical and Dramatic Academy", type: "public"),
                University(name: "Bais Medrash Elyon", type: "public"),
                University(name: "Bank Street College of Education", type: "public"),
                University(name: "Barnard College", type: "public"),
                University(name: "CUNY Graduate School and University Center", type: "public"),
                University(name: "Colgate University", type: "public"),
                University(name: "College of Mount Saint Vincent", type: "public"),
                University(name: "Columbia University in the City of New York", type: "public"),
                University(name: "Culinary Institute of America", type: "public"),
                University(name: "Globe Institute of Technology", type: "public"),
                University(name: "Hebrew Union College-Jewish Institute of Religion", type: "public"),
                University(name: "Icahn School of Medicine at Mount Sinai", type: "public"),
                University(name: "Kehilath Yakov Rabbinical Seminary", type: "public")
            ]))
        }
    }
}
