//
//  FeatureFlagging.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/8/22.
//

import Foundation

public enum Flow {
    case new
}

public enum Feature {
    case newFlow(Flow)
    case newVersion(String)
}

protocol FeatureFlaggingService {
    func featureEnabled(_ feature: Feature) -> Bool
}

final class FeatureFlagging: FeatureFlaggingService {
    
    let appConfig: AppConfiguration
    
    init(appConfiguration: AppConfiguration) {
        self.appConfig = appConfiguration
    }
    
    func featureEnabled(_ feature: Feature) -> Bool {
        switch feature {
        case .newFlow(let flow):
            switch flow {
            case .new:
                return appConfig.executeNewFlow
            }
        case .newVersion(let appVersionNumber):
            return appConfig.maximumIOSVersion <= appVersionNumber
        }
    }
}
