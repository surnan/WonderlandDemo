import UIKit

extension AvatarView {

  // MARK:- Social Media Icons
  
  class func createSocialMediaView() -> UIStackView {
    // Social media stack view
    var icons = [UIImageView]()
    icons.append(UIImageView(image: UIImage(named: "icon_facebook")))
    icons.append(UIImageView(image: UIImage(named: "icon_pinterest")))
    icons.append(UIImageView(image: UIImage(named: "icon_twitter")))
    
    let socialMediaView = UIStackView(arrangedSubviews: icons)
    socialMediaView.translatesAutoresizingMaskIntoConstraints = false
    socialMediaView.axis = .horizontal
    socialMediaView.distribution = .equalSpacing
    return socialMediaView
  }
}
