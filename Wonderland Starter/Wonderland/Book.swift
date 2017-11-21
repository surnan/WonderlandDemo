import Foundation

struct Book {
  var textArray: NSArray?
  var chapterImagesArray: NSArray?
  
  var title: String?
  var author: String?
  
  var chapterText: String?
  var chapterImageName: String?
  
  init() {
    guard let plistPath = Bundle.main.path(forResource: "AliceInWonderland",
                          ofType: "plist") else { return }
    guard let dictionary = NSDictionary(contentsOfFile: plistPath) else { return }
    
    textArray = dictionary["Text"] as? NSArray
    chapterImagesArray = dictionary["ChapterImages"] as? NSArray
    
    title = dictionary["Title"] as? String
    author = dictionary["Author"] as? String
  }
  
  mutating func loadChapter(_ chapter: Int) -> Bool {
    
    guard let bookTextArray = textArray else { return false }
    guard let chapterImagesArray = chapterImagesArray else { return false }
    
    guard bookTextArray.count >= chapter && chapter > 0 else { return false }
    chapterText = bookTextArray[chapter-1] as? String
    chapterImageName = chapterImagesArray[chapter-1] as? String
    
    return true
  }
}
