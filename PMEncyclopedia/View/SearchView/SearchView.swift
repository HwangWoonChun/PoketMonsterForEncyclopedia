//
//  SearchView.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/15.
//

import UIKit

class SearchView: UIView {
    
    @IBOutlet var textField: UITextField!
    
    public var viewModel: SearchViewModel!
    
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
        guard let view = loadNib(nibName: "SearchView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        //
        self.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let string = textField.text else { return }
        if string.count > 0 {
            self.viewModel.searchText = string
            self.viewModel.searchResult = self.viewModel.searchPokemon()
        }
    }
}

extension SearchView: Bindable {
    func bindViewModel() {
        
    }
}
