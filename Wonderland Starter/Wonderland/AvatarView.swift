import UIKit

class AvatarView: UIView {
    
    fileprivate var regularConstraints = [NSLayoutConstraint]()
    fileprivate var compactConstraints = [NSLayoutConstraint]()
    fileprivate var aspectRatioConstraint:NSLayoutConstraint?
    
    
    var image: UIImage? {
        didSet {
            imageView.image = image
            setNeedsUpdateConstraints()   // <-- whenever the image property is set, all constraints will be recalculated and updated
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 100)
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        socialMediaView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelBottom = titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        let imageViewTop = imageView.topAnchor.constraint(equalTo: topAnchor)
        let imageViewBottom = imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor)
        
        let socialMediaTrailing = socialMediaView.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        
        NSLayoutConstraint.activate([                                                                       //More activations happening
            imageViewTop, imageViewBottom,
            labelBottom,
            socialMediaTrailing])
        
        imageView.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow,for: .vertical)        //Without these 2 lines, no "ALICE IN WONDERLAND" label
        imageView.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow,for: .horizontal)      //Instead of image's intrinsic size, it willingly compresses
        //which allows label under it's bottom anchor chance to show
        socialMediaView.axis = .vertical
        
        
        compactConstraints.append(imageView.centerXAnchor.constraint(equalTo: centerXAnchor))
        compactConstraints.append(titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor))
        compactConstraints.append(socialMediaView.topAnchor.constraint(equalTo: topAnchor))
        
        regularConstraints.append(imageView.leadingAnchor.constraint(equalTo: leadingAnchor))
        regularConstraints.append(titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor))
        regularConstraints.append(socialMediaView.bottomAnchor.constraint(equalTo: bottomAnchor))
    }
    
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        //Check size class
        if traitCollection.horizontalSizeClass == .regular {
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
            socialMediaView.axis = .horizontal
        } else {
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
            socialMediaView.axis = .vertical
        }
    }
    
    // Views
    fileprivate let titleLabel = UILabel()
    fileprivate let imageView = UIImageView()
    fileprivate lazy var socialMediaView: UIStackView = {
        return AvatarView.createSocialMediaView()
    }()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        setup()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.height < socialMediaView.bounds.height {
            socialMediaView.alpha = 0
        } else {
            socialMediaView.alpha = 1
        }
        if imageView.bounds.height < 30 {
            imageView.alpha = 0
        } else {
            imageView.alpha = 1
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        // 1
        var aspectRatio: CGFloat = 1    // used in division later.  Set it to one in case no image exists
        if let image = image {          // if you do pull an image, properly calculate aspect ratio for below calculation
            aspectRatio = image.size.width / image.size.height
        }
        // 2
        aspectRatioConstraint?.isActive = false  //don't add constraints until you remove unnecessary ones
        aspectRatioConstraint = imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor,multiplier: aspectRatio)
        aspectRatioConstraint?.isActive = true
    }
    
    func setup() {
        imageView.contentMode = .scaleAspectFit
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 28.0)
        titleLabel.textColor = UIColor.black
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(socialMediaView)
    }
}
