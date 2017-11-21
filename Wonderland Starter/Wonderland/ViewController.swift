import UIKit

class ViewController: UIViewController {
  
  var chapterNumber = 1
  var book = Book()
  
  // views
  let avatarView = AvatarView()
  let bookTextView = UITextView()
  let chapterLabel = UILabel()

    
    func setupConstraints(){
        bookTextView.translatesAutoresizingMaskIntoConstraints = false
        bookTextView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor).isActive = true
        bookTextView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor).isActive = true
        bookTextView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor,constant: -20).isActive = true      //20 points off the bottom
        bookTextView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.65).isActive = true   //65% of the total height
        
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        avatarView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        avatarView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        //avatarView.heightAnchor.constraint(equalToConstant: 200).isActive = true //avatarView's height is constant 200  //later unnecessary because intrinsic size set in AvatarView.swift
        avatarView.bottomAnchor.constraint(equalTo: chapterLabel.topAnchor,constant: -10).isActive = true   //10 units of white space between them
        
        
        chapterLabel.translatesAutoresizingMaskIntoConstraints = false
        chapterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true                  //Center position covers left&right
        chapterLabel.bottomAnchor.constraint(equalTo: bookTextView.topAnchor).isActive = true               //Font size gives height constraint
        //hugging
        chapterLabel.setContentHuggingPriority(UILayoutPriorityRequired,for: .vertical)
        chapterLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired,for: .vertical)
    }
    
    
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    _ = book.loadChapter(chapterNumber)
    updateViews()   // load the views with book data
    addGestures()   // swipe gestures to turn the page
    addViews()      // add the sub views to the main view
    setupConstraints()
  }
}

