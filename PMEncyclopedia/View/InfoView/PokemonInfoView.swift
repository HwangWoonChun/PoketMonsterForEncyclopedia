//
//  PokemonInfoView.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/17.
//

import UIKit

protocol PokemonInfoViewDelegate {
    func moveToMap()
}

class PokemonInfoView: UIView {

    @IBOutlet var mainView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var subNameLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var mapButton: UIButton!
    
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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mainView.layer.masksToBounds = true
        self.mainView.layer.cornerRadius = 16
    }
    
    @IBAction func touchedCloseButton(sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBAction func touchedMapButton(sender: Any) {

    }
}

extension PokemonInfoView: Bindable {
    func bindViewModel() {
        DispatchQueue.main.async {
            self.imageView.image = nil
            let count = self.viewModel.locations?.count ?? 0
            self.mapButton.isHidden = count > 0 ? false : true
            self.nameLabel.text = self.viewModel.name?[0] ?? ""
            self.subNameLabel.text = self.viewModel.name?[1] ?? ""
            self.heightLabel.text = "height : \(self.viewModel.pokemon?.height ?? 0)"
            self.weightLabel.text = "weight : \(self.viewModel.pokemon?.weight ?? 0)"
            self.imageView.downloadImage(from: self.viewModel.imageURL ?? "")
        }
    }
}
