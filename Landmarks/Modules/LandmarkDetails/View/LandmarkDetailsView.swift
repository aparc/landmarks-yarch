//
//  Created by Andrei on 02/11/2022.
//

import MapKit

extension LandmarkDetailsView {
    struct Appearance {
        let backgroundColor: UIColor = .white
        
        let favoriteIconColor: UIColor = .init(red: 247/255, green: 205/255, blue: 70/255, alpha: 1.0 )
        let favoriteIconWidth: CGFloat = 28
        let leftFavoriteIconOffset: CGFloat = 20
        
        let landmarkNameLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0)
            
        let landmarkParkLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 0)
        
        let landmarkStateLabelEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: -20)
    }
}

class LandmarkDetailsView: UIView {
    
    // MARK: - Private Properties
    private let appearance = Appearance()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = appearance.backgroundColor
        return view
    }()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.isZoomEnabled = false
        map.isScrollEnabled = false
        map.isUserInteractionEnabled = false
        return map
    }()
    
    private lazy var containerImageView: UIView =  {
        let width = bounds.width * 0.6
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.clipsToBounds = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 7
        view.layer.cornerRadius = width / 2
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: width / 2).cgPath
        return view
    }()
    
    private lazy var landmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = bounds.width * 0.6 / 2
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var landmarkNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var favoriteIcon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "star.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.tintColor = appearance.favoriteIconColor
        
        return imageView
    }()
    
    private lazy var landmarkParkLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var landmarkStateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return label
    }()
    
    // MARK: - Init Methods
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configureView(with viewModel: LandmarkDetailsViewModel) {
        landmarkImageView.image = UIImage(named: viewModel.imageName)
        landmarkNameLabel.text = viewModel.name
        favoriteIcon.isHidden = !viewModel.isFavorite
        landmarkParkLabel.text = viewModel.park
        landmarkStateLabel.text = viewModel.state
        let coordinateRegion = MKCoordinateRegion(center: viewModel.locationCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    // MARK: - Private Methods
    private func addSubviews(){
        containerImageView.addSubview(landmarkImageView)
        
        containerView.addSubview(mapView)
        containerView.addSubview(containerImageView)
        containerView.addSubview(landmarkNameLabel)
        containerView.addSubview(favoriteIcon)
        containerView.addSubview(landmarkParkLabel)
        containerView.addSubview(landmarkStateLabel)
        
        addSubview(containerView)
    }
    
    // MARK: - Layout
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
        }
        
        landmarkImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerImageView.snp.makeConstraints { make in
            make.centerY.equalTo(mapView.snp.bottom)
            make.centerX.equalTo(containerView.snp.centerX)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(containerImageView.snp.width)
        }
        
        landmarkNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(appearance.landmarkNameLabelInsets.left)
            make.top.equalTo(containerImageView.snp.bottom).offset(appearance.landmarkNameLabelInsets.top)
        }
        
        favoriteIcon.snp.makeConstraints { make in
            make.height.width.equalTo(appearance.favoriteIconWidth)
            make.left.equalTo(landmarkNameLabel.snp.right).offset(appearance.leftFavoriteIconOffset)
            make.centerY.equalTo(landmarkNameLabel.snp.centerY)
        }
        
        landmarkParkLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(appearance.landmarkParkLabelInsets.left)
            make.top.equalTo(landmarkNameLabel.snp.bottom).offset(appearance.landmarkParkLabelInsets.top)
        }
        
        landmarkStateLabel.snp.makeConstraints { make in
            make.left.equalTo(landmarkParkLabel.snp.right)
            make.right.equalToSuperview().offset(appearance.landmarkStateLabelEdgeInsets.right)
            make.top.equalTo(landmarkNameLabel.snp.bottom).offset(appearance.landmarkStateLabelEdgeInsets.top)
        }
    }
}
