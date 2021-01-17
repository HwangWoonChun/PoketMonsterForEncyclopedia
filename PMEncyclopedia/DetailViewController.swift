//
//  DetailViewController.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/17.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var mapView: MTMapView?
    public var viewModel: LocationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView = MTMapView(frame: self.view.bounds)
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            self.view.addSubview(mapView)
        }
    }
}

extension DetailViewController: Bindable {
    func bindViewModel() {
        guard let location = viewModel.locations else { return }
        guard let mapView = self.mapView else { return }
        guard let firstLoc = location.first else { return }
        
        let firstGeo = MTMapPointGeo(latitude: firstLoc.lat, longitude: firstLoc.lng)
        let firstPoint = MTMapPoint(geoCoord: firstGeo)
        mapView.setMapCenter(firstPoint, animated: true)

        let pointList: [MTMapPOIItem] = location.map {
            let geo = MTMapPointGeo(latitude: $0.lat, longitude: $0.lng)
            let point = MTMapPoint(geoCoord: geo)
            let poItem = MTMapPOIItem()
            poItem.mapPoint = point
            return poItem
        }
        
        mapView.addPOIItems(pointList)
    }
}

extension DetailViewController: MTMapViewDelegate {
    
}
