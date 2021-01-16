//
//  Bindable.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/16.
//

import UIKit

protocol Bindable {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension Bindable where Self: UIView {
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}
