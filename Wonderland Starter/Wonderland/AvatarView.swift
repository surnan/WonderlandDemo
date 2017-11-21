/**
 Copyright (c) 2016 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

class AvatarView: UIView {
  
  var image: UIImage? {
    didSet {
      imageView.image = image
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
        
        // 1
        let labelBottom = titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        let labelCenterX = titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        // 2
        let imageViewTop = imageView.topAnchor.constraint(equalTo: topAnchor)
        let imageViewBottom = imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor)
        let imageViewCenterX = imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        // 3
        let socialMediaTrailing = socialMediaView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let socialMediaTop = socialMediaView.topAnchor.constraint(equalTo: topAnchor)

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
  
  func setup() {
    imageView.backgroundColor = UIColor.magenta
    titleLabel.backgroundColor = UIColor.orange
    
    imageView.contentMode = .scaleAspectFit
    titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 28.0)
    titleLabel.textColor = UIColor.black
    addSubview(imageView)
    addSubview(titleLabel)
    addSubview(socialMediaView)
  }
}
