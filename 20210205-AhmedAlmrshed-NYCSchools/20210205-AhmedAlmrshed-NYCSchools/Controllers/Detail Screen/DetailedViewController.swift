//
//  DetailedViewController.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/6/22.
//

import UIKit


/// I did not focus on UI at all, I just made a few lables to hold loaded values.

class DetailedViewController: UIViewController {
    var service: DetailService?
    var school: School? {
        didSet {
            schoolName.text = school?.name
            schoolWeb.text  = "Web: \(school?.website ?? "N/A")"
            schoolNeighborhood.text = "Neighborhood: \(school?.neighborhood ?? "N/A")"
            schoolAddress.text = "Address: \(school?.location ?? "N/A")"
            schoolTotalStudents.text = "Students: \(school?.totalStudents ?? "N/A")"
        }
    }
    
    var schoolDetail: SchoolDetail? {
        didSet {
            if let mathAvgScore = schoolDetail?.satMathAvgScore,
               let readingAvgScore = schoolDetail?.satReadingAvgScore,
               let writingAvgScore = schoolDetail?.satWritingAvgScore {
                schoolSAT.text = "SAT average scores: \nMath \(mathAvgScore), \nReading \(readingAvgScore), \nWriting \(writingAvgScore)"
            }
            
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let schoolName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let schoolWeb: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let schoolNeighborhood: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let schoolAddress: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let schoolTotalStudents: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let schoolSAT: UILabel = {
        let label = UILabel()
        label.text = "SAT average score: \nMath: N/A, Reading: N/A, Writing: N/A"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDetails()
    }
    
    private func configureView() {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo:view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo:view.rightAnchor),
            containerView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
 
        
        containerView.addSubviews(views:[
            schoolName,
            schoolWeb,
            schoolNeighborhood,
            schoolAddress,
            schoolTotalStudents,
            schoolSAT
        ])
        
        NSLayoutConstraint.activate([
            schoolName.leftAnchor.constraint(equalTo:containerView.leftAnchor, constant: 10),
            schoolName.heightAnchor.constraint(equalToConstant: 60),
            schoolName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            schoolName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            schoolWeb.leftAnchor.constraint(equalTo:containerView.leftAnchor, constant: 10),
            schoolWeb.heightAnchor.constraint(equalToConstant: 50),
            schoolWeb.topAnchor.constraint(equalTo: schoolName.topAnchor, constant: 70),
            schoolWeb.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            schoolNeighborhood.leftAnchor.constraint(equalTo:containerView.leftAnchor, constant: 10),
            schoolNeighborhood.heightAnchor.constraint(equalToConstant: 50),
            schoolNeighborhood.topAnchor.constraint(equalTo: schoolWeb.topAnchor, constant: 25),
            schoolNeighborhood.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            schoolAddress.leftAnchor.constraint(equalTo:containerView.leftAnchor, constant: 10),
            schoolAddress.heightAnchor.constraint(equalToConstant: 65),
            schoolAddress.topAnchor.constraint(equalTo: schoolNeighborhood.topAnchor, constant: 25),
            schoolAddress.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            schoolTotalStudents.leftAnchor.constraint(equalTo:containerView.leftAnchor, constant: 10),
            schoolTotalStudents.heightAnchor.constraint(equalToConstant: 80),
            schoolTotalStudents.topAnchor.constraint(equalTo: schoolAddress.topAnchor, constant: 25),
            schoolTotalStudents.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            schoolSAT.leftAnchor.constraint(equalTo:containerView.leftAnchor, constant: 10),
            schoolSAT.heightAnchor.constraint(equalToConstant: 100),
            schoolSAT.topAnchor.constraint(equalTo: schoolTotalStudents.topAnchor, constant: 40),
            schoolSAT.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private func loadDetails() {
        guard let name = school?.name else { return }
        service?.loadDetailItem(using: name , completion: handleAPIResult)
    }
    
    private func handleAPIResult(_ result: Result<[SchoolDetail], AppError>) {
        switch result {
        case let .success(item):
            schoolDetail = item.first
        case let .failure(error):
            switch error {
            case .custom(type: .dataConverstionIssue):
                // Many schools don't have SAT data available, so when
                // data converstion fails in this case that means our filtering
                // don't find a match. This is why I ignore this case and show
                // Default values.
            return
            default:
                show(error: error)
            }
        }
    }

}

extension UIView {
    func addSubviews(views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}
