//
//  AppConfiguration.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/8/22.
//

import Foundation

/// This just to simulate an external app configuration load.
/// This usualy is fetched out of external API to make app more executable
/// without the need to manually distribute a binary based on requirements'
/// change for `app configuration`.

struct AppConfiguration {
    let isCacheLookupPriority: Bool
    let numberOfCacheLoadTry: UInt
    let minimumIOSVersion: String
    let maximumIOSVersion: String
    let executeNewFlow: Bool

}

class AppConfigurationService {
    func loadAppConfiguration() -> AppConfiguration {
        /// Based on requirements, we can either frequently, or once every week,
        /// make an API call to fetch `appConfig`, or cache it locally and fetch
        /// cached value of `appConfig`.

        /// This mockup to what could be a decoded data JSON.
        return AppConfiguration(
            isCacheLookupPriority: true,
            numberOfCacheLoadTry: 1,
            minimumIOSVersion: "11.0",
            maximumIOSVersion: "14.1",
            executeNewFlow: false
        )
    }
}
