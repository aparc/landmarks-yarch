//
//  PlacesFavoriteSwitch.swift
//  Places
//
//  Created by Андрей Парчуков on 02.11.2022.
//

import UIKit

protocol LandmarksFavoriteSwitcherDelegate: AnyObject {
    func showFavorites(_ on: Bool)
}

extension LandmarksFavoriteSwitcherView {
    struct Appearance {
        let labelInset: CGFloat = 16
        
        let toggleRightOffset: CGFloat = -16
        
        let borderThickness: CGFloat = 1
        let borderColor: CGColor = UIColor.systemGray5.cgColor
    }
}

class LandmarksFavoriteSwitcherView: UIView {
    
    // MARK: - Public Properties
    var appearance: Appearance = Appearance()
    weak var delegate: LandmarksFavoriteSwitcherDelegate?
    
    //MARK: - Private Properties
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Favorites only"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var toggle: UISwitch = {
        var toggle = UISwitch()
        toggle.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
        return toggle
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addBorders()
    }
    
    //MARK: - Private Methods
    private func addBorders() {
        let topBorder = CALayer()
        let bottomBorder = CALayer()
        topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: appearance.borderThickness)
        topBorder.backgroundColor = appearance.borderColor
        bottomBorder.frame = CGRect(
            x:0,
            y: self.frame.size.height - appearance.borderThickness,
            width: self.frame.size.width,
            height: appearance.borderThickness
        )
        bottomBorder.backgroundColor = appearance.borderColor
        self.layer.addSublayer(topBorder)
        self.layer.addSublayer(bottomBorder)
    }
    
    @objc private func switchStateDidChange(_ sender: UISwitch) {
        delegate?.showFavorites(sender.isOn)
    }
    
    private func addSubviews() {
        addSubview(label)
        addSubview(toggle)
    }
    
    private func addConstraints() {
        label.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(self).inset(appearance.labelInset)
        }
        toggle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(appearance.toggleRightOffset)
        }
    }
    
}
