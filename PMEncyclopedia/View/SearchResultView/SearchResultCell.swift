//
//  SearchResultCell.swift
//  PMEncyclopedia
//
//  Created by WOONCHUN HWANG on 2021/01/17.
//

import UIKit

class SearchResultCell: UITableViewCell {
    var viewModel: SearchResultViewModel!
    
    @IBOutlet var titleLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
    }
}

extension SearchResultCell: Bindable {
    func bindViewModel() {
        DispatchQueue.main.async {
            let fullText = self.viewModel.koreanName ?? ""
            let strNumber: NSString = fullText as NSString
            let range = (strNumber).range(of: self.viewModel.searchText ?? "")
            let attribute = NSMutableAttributedString.init(string: fullText)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue , range: range)
            self.titleLabel.attributedText = attribute
        }
    }
}
