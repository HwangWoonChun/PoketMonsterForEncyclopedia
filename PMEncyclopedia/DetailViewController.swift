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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView = MTMapView(frame: self.view.bounds)
        if let mapView = mapView {
            mapView.baseMapType = .standard
            self.view.addSubview(mapView)
        }
    }
}

// MARK: - Bindable
extension DetailViewController: Bindable {
    func bindViewModel() {
        guard let mapView = self.mapView else { return }
        guard let pointList = viewModel.pointList else { return }
        mapView.setMapCenter(pointList.first?.mapPoint, animated: true)
        mapView.addPOIItems(pointList)
    }
}
