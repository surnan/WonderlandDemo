
import UIKit

extension ViewController {
  
  // MARK:- Add the subviews
  
  func addViews() {
    
    // Add bookTextView
    view.addSubview(bookTextView)
    bookTextView.font = UIFont.systemFont(ofSize: 12)
    bookTextView.isSelectable = false
    bookTextView.isEditable = false
    
    // Add chapterLabel
    chapterLabel.textAlignment = .center
    view.addSubview(chapterLabel)
    
    // Add avatarView
    view.addSubview(avatarView)
  }

  // MARK:- Color the views
  
  func colorViews() {
    // color views for reference
    bookTextView.backgroundColor = UIColor.green
    chapterLabel.backgroundColor = UIColor.yellow
    avatarView.backgroundColor = UIColor.cyan
  }

  // MARK:- Set up frames before using Auto Layout 
  
  func setupFrames() {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    // setup frames
    let bookTextViewHeight = screenHeight * 0.65
    bookTextView.frame = CGRect(x: 0,
      y: screenHeight-bookTextViewHeight,
      width: screenWidth,
      height: bookTextViewHeight)
    chapterLabel.sizeToFit()
    chapterLabel.frame = CGRect(x: 0,
      y: bookTextView.frame.origin.y - chapterLabel.bounds.height,
      width: screenWidth,
      height: chapterLabel.bounds.height)
    avatarView.frame = CGRect(x: 0,
      y: 0,
      width: screenWidth,
      height: screenHeight - bookTextView.bounds.height
        - chapterLabel.bounds.height)
  }
  
  // MARK:- Swipe Gesture setup
  
  func addGestures() {
    
    // Next Chapter
    
    let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeChapter(_:)))
    swipeRightGesture.direction = .right
    bookTextView.addGestureRecognizer(swipeRightGesture)
    
    let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeChapter(_:)))
    swipeLeftGesture.direction = .left
    bookTextView.addGestureRecognizer(swipeLeftGesture)
  }
  
  
  func changeChapter(_ gesture:UISwipeGestureRecognizer) {
    var chapter = chapterNumber
    if gesture.direction == .right {
      chapter -= 1
    }
    if gesture.direction == .left {
      chapter += 1
    }
    if book.loadChapter(chapter) {
      chapterNumber = chapter
    }
    updateViews()
  }
  
  // MARK:- Book Loading
  
  func updateViews() {
    bookTextView.text = book.chapterText
    chapterLabel.text = "Chapter \(chapterNumber)"
    avatarView.title = book.title
    if let imageName = book.chapterImageName {
      avatarView.image = UIImage(named: imageName)
    }
    bookTextView.contentOffset = .zero
    bookTextView.scrollRectToVisible(
      CGRect(origin: .zero, size: bookTextView.bounds.size),
      animated: false)
  }
  
  
  // MARK:- Scroll text on rotation
  
  override func viewDidLayoutSubviews() {
    bookTextView.scrollRangeToVisible(visibleRangeOfTextView(bookTextView))
  }
  
  // courtesy of
  // http://stackoverflow.com/a/28896715/359578
  
  fileprivate func visibleRangeOfTextView(_ textView: UITextView) -> NSRange {
    let bounds = textView.bounds
    let origin = CGPoint(x: 100,y: 100) //Overcome the default UITextView left/top margin
    let startCharacterRange = textView.characterRange(at: origin)
    if startCharacterRange == nil {
      return NSMakeRange(0,0)
    }
    let startPosition = textView.characterRange(at: origin)!.start
    
    let endCharacterRange = textView.characterRange(at: CGPoint(x: bounds.maxX, y: bounds.maxY))
    if endCharacterRange == nil {
      return NSMakeRange(0,0)
    }
    let endPosition = textView.characterRange(at: CGPoint(x: bounds.maxX, y: bounds.maxY))!.end
    
    let startIndex = textView.offset(from: textView.beginningOfDocument, to: startPosition)
    let endIndex = textView.offset(from: startPosition, to: endPosition)
    return NSMakeRange(startIndex, endIndex)
  }
  
  // MARK:- View Controller methods
  
  override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
    return .all
  }

}
