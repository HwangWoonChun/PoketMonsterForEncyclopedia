//
//  SearchView.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/15.
//

import UIKit

protocol SearchViewDelegate {
    func endSearch()
}

class SearchView: UIView {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var backgoundView: UIView!
    @IBOutlet var circleView: UIView!
    
    public var viewModel: SearchViewModel!
    public var delegate: SearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgoundView.layer.masksToBounds = true
        backgoundView.layer.cornerRadius = 16
        
        circleView.layer.masksToBounds = true
        circleView.layer.cornerRadius = circleView.frame.size.width/2
    }

    private func setup() {
        //load
        guard let view = loadNib(nibName: "SearchView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        //
        self.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let string = textField.text else { return }
        
        self.viewModel.searchText = string
        //
        if string.count == 0 {
            self.viewModel.searchResult = []
        } else {
            self.viewModel.searchResult = self.viewModel.searchPokemon()
        }
        //
        self.delegate?.endSearch()

    }
}

extension SearchView: Bindable {
    func bindViewModel() {
        let count = self.viewModel.pokemons?.pokemons.count ?? 0
        DispatchQueue.main.async {
            self.countLabel.text = "포켓몬 총 \(count) 마리"
        }
    }
}
