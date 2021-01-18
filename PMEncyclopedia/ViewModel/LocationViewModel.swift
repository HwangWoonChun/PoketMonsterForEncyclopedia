//
//  LocationViewModel.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/17.
//

import Foundation

struct LocationViewModel {

    let locations: [Location]?
    let pointList: [MTMapPOIItem]?

    init(locations: [Location]?) {
        self.locations = locations
        
        if let locations = self.locations {
            self.pointList = locations.map {
                let geo = MTMapPointGeo(latitude: $0.lat, longitude: $0.lng)
                let point = MTMapPoint(geoCoord: geo)
                let poItem = MTMapPOIItem()
                poItem.mapPoint = point
                return poItem
            }
        } else {
            pointList = nil
        }
    }
}
