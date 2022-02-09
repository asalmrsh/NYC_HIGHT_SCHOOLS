//
//  MainTabBarController.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/6/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    private var schoolCache: SchoolCache!
    var appConfig: AppConfiguration!
    var featureFlagging: FeatureFlagging!
    
    convenience init(schoolCache: SchoolCache, appConfig: AppConfiguration, featureFlagging: FeatureFlagging) {
        self.init(nibName: nil, bundle: nil)
        self.schoolCache = schoolCache
        self.appConfig = appConfig
        self.featureFlagging = featureFlagging
        self.setupViewController()
    }
    
    private func setupViewController() {
        if featureFlagging.featureEnabled(.newFlow(.new)) {
            viewControllers = [
                createNavigation(for: makeSchoolList(), title: "School", icon: "list.dash"),
                createNavigation(for: makeUniversityList(), title: "University", icon: "list.dash")
            ]
        }
        else {
            viewControllers = [
                createNavigation(for: makeSchoolList(), title: "School", icon: "list.dash")
            ]
        }
    }
        
    private func createNavigation(for vc: UIViewController, title: String, icon: String) -> UIViewController {
        vc.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = UIImage(
            systemName: icon,
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
        nav.tabBarItem.title = title
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
    
    private func makeSchoolList() -> ListViewController {
        let vc = ListViewController()
        vc.title = "Schools"
        
        let cache = SchoolCacheAdapter(
            schoolCache: schoolCache,
            select: { [weak vc] item in
                vc?.select(school: item)
            }).retry(appConfig.numberOfCacheLoadTry)
        
        let api = SchoolAdapter(
            schoolAPI: SchoolAPI.shard,
            select: { [weak vc] item in
                vc?.select(school: item)
            })
        
        vc.service = appConfig.isCacheLookupPriority ? cache.fallback(api) : api
        return vc
    }
    
    private func makeUniversityList() -> ListViewController {
        let vc = ListViewController()
        vc.title = "Universities"
        
        let cache = UniversityCacheAdapter(
            schoolCache: schoolCache,
            select: { [weak vc] item in
                vc?.select(school: item)
            }).retry(appConfig.numberOfCacheLoadTry)
        
        let api = UniversityAdapter(
            universityAPI: UniversityAPI.shard,
            select: { [weak vc] item in
                vc?.select(university: item)
            })
        
        vc.service = appConfig.isCacheLookupPriority ? cache.fallback(api) : api
        return vc
    }

}
