//
//  PlacesFavoriteSwitch.swift
//  Places
//
//  Created by Андрей Парчуков on 02.11.2022.
//

import UIKit

extension LandmarksFavoriteSwitcherCell {
    struct Appearance {
        let labelInset: CGFloat = 16
    }
}

class LandmarksFavoriteSwitcherCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let reuseIdentifier = "landmarksFavoriteSwitcherCell"

    var appearance: Appearance = Appearance()
    weak var delegate: LandmarksViewControllerDelegate?
    
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
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = toggle
        selectionStyle = .none
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    @objc private func switchStateDidChange(_ sender: UISwitch) {
        delegate?.showFavorites(sender.isOn)
    }
    
    private func addSubviews() {
        contentView.addSubview(label)
    }
    
    private func addConstraints() {
        label.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(contentView).inset(appearance.labelInset)
        }
    }
    
}
