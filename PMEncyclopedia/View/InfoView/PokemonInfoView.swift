//
//  PokemonInfoView.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/17.
//

import UIKit

class PokemonInfoView: UIView {

    public var viewModel: InfoViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        //load
        guard let view = loadNib(nibName: "PokemonInfoView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
}

extension PokemonInfoView: Bindable {
    func bindViewModel() {
        print(viewModel.locations)
        DispatchQueue.main.async {

        }
    }
}
