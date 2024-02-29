//
//  SearchTableViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import UIKit
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let symbolLabel = UILabel()
    let favoriteButton = UIButton()
    
    var delegate: PassDataProtocol?
    
    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(favoriteButton)
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.width.height.equalTo(45)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
        symbolLabel.snp.makeConstraints { make in
            make.bottom.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        favoriteButton.snp.makeConstraints { make in
            make.height.width.equalTo(45)
            make.verticalEdges.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
        }
        
    }
    
    override func configureView() {
        selectionStyle = .none
        
        iconImageView.contentMode = .scaleAspectFill
        
        nameLabel.textColor = .titleColor
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        nameLabel.font = .boldBody

        
        symbolLabel.textColor = .secondaryLabel
        symbolLabel.numberOfLines = 1
        symbolLabel.textAlignment = .left
        symbolLabel.font = .caption
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }

}

extension SearchTableViewCell {
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(tag: sender.tag)
    }
    
    func configureCell(data: Item, searchText: String?) {
        favoriteButton.setImage(SetButtonToggleColor.shared.setColor(id: data.id), for: .normal)
        nameLabel.text = data.name
        symbolLabel.text = data.symbol
        iconImageView.kf.setImage(with: URL(string: data.large))
        
        guard let text = self.nameLabel.text else { return }
        guard let searchText else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.pointColor, range: (text.lowercased() as NSString).range(of: searchText))
        self.nameLabel.attributedText = attributeString
    }
}
