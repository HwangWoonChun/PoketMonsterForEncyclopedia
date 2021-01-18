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
        //위 경도 정보
        self.locations = locations
        //요구사항 3 : 서식지 마커 리스트 정보
        if let locations = self.locations {
            self.pointList = locations.map {
                let geo = MTMapPointGeo(latitude: $0.lat ?? 0, longitude: $0.lng ?? 0)
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
