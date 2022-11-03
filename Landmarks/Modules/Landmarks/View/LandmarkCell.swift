//
//  PlaceCell.swift
//  Places
//
//  Created by Андрей Парчуков on 01.11.2022.
//

import UIKit

extension LandmarkCell {
    struct Appearance {
        let labelFontSize: CGFloat = 24
        let imageViewTintColor: UIColor = .init(red: 247/255, green: 205/255, blue: 70/255, alpha: 1)
        let landmarkImageEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 0)
        let labelLeftOffset: CGFloat = 8
        let favoriteIconHeight: CGFloat = 30
        let favoriteIconRightOffset: CGFloat = -8
    }
}

class LandmarkCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let reuseIdentifier = "landmarkCell"
    
    var appearance: Appearance = Appearance()
    
    // MARK: - Private Properties
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: appearance.labelFontSize)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var landmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var favouriteIcon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "star.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.tintColor = appearance.imageViewTintColor
        imageView.isHidden = true
        
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        landmarkImageView.layer.cornerRadius = landmarkImageView.frame.height / 2
    }
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        setupViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with cellPresentable: LandmarksViewModel) {
        label.text = cellPresentable.name
        landmarkImageView.image = UIImage(named: cellPresentable.imageName)
        favouriteIcon.isHidden = !cellPresentable.isFavorite
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        contentView.addSubview(label)
        contentView.addSubview(landmarkImageView)
        contentView.addSubview(favouriteIcon)
    }

    private func addConstraints() {
        landmarkImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(appearance.landmarkImageEdgeInsets)
            make.width.equalTo(landmarkImageView.snp.height)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(landmarkImageView.snp.right).offset(appearance.labelLeftOffset)
            make.top.bottom.equalToSuperview()
        }
        
        favouriteIcon.snp.makeConstraints { make in
            make.height.equalTo(appearance.favoriteIconHeight)
            make.height.equalTo(favouriteIcon.snp.width)
            make.right.equalToSuperview().offset(appearance.favoriteIconRightOffset)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
}
