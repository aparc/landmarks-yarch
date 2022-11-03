//
//  LandmarksEmptyView.swift
//  Places
//
//  Created by Андрей Парчуков on 03.11.2022.
//

import UIKit

extension LandmarksEmptyView {
    struct Appearance {
        let titleColor = UIColor.black
        
        let subtitleColor = UIColor.gray
        
        let backgroundColor = UIColor.white
        
        let titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let subtitleInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
}

class LandmarksEmptyView: UIView {
    
    // MARK: - Public Properties
    let appearance: Appearance
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = self.appearance.titleColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "There is no data"
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.textColor = self.appearance.subtitleColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Try later"
        return label
    }()
    
    // MARK: - Private Properties
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = self.appearance.backgroundColor
        return view
    }()

    // MARK: - Init Methods
    init(frame: CGRect = .zero, appearance: Appearance = Appearance()) {
        self.appearance = appearance
        super.init(frame: frame)
        backgroundColor = appearance.backgroundColor
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        addSubview(view)
        view.addSubview(title)
        view.addSubview(subtitle)
    }
    
    // MARK: - Layout
    private func makeConstraints() {
        view.snp.makeConstraints { make in
            make.left.right.centerY.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(appearance.subtitleInsets.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
