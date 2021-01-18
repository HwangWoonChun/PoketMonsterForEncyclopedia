//
//  PokemonInfoView.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/17.
//

import UIKit

protocol PokemonInfoViewDelegate {
    func moveToMap(locations: [Location]?)
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
    public var delegate: PokemonInfoViewDelegate?
    
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
        self.delegate?.moveToMap(locations: self.viewModel.locations)
    }
}

extension PokemonInfoView: Bindable {
    func bindViewModel() {
        DispatchQueue.main.async {
            //요구사항 2-a : 이름, 대표 이미지, 키, 몸무게, 알려진 서식지 여부
            self.imageView.image = nil
            //요구사항 2-d : 서식지 여부
            self.mapButton.isHidden = (self.viewModel.isHaveLocation ?? false) ? false : true
            //요구사항 2-b : 영문, 한글 이름 모두 표기
            self.nameLabel.text = self.viewModel.name?[0] ?? ""
            self.subNameLabel.text = self.viewModel.name?[1] ?? ""
            //몸무게, 키
            let height = self.viewModel.pokemon?.height ?? 0
            let weight = self.viewModel.pokemon?.weight ?? 0
            self.heightLabel.text = "height : \(height.withCommas())"
            self.weightLabel.text = "weight : \(weight.withCommas())"
            //이미지
            self.imageView.downloadImage(from: self.viewModel.imageURL ?? "")
        }
    }
}
