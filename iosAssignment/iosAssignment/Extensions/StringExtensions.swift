//
//  String.swift
//  Ketch
//
//  Created by C110 on 15/12/17.
//  Copyright © 2017 C110. All rights reserved.
//

import UIKit

extension String: Error {}

extension String {
    /*var localized: String {
            return NSLocalizedString(self, comment: "")
        }*/
        
       /* func localized(_ arguments: CVarArg...) -> String {
            return String(format: self.localized, arguments: arguments)
        }*/
    
//    func fromBase64() -> String? {
//        guard let data = Data(base64Encoded: self) else {
//            return ""
//        }
//        
//        return String(data: data, encoding: .utf8)
//    }
//    
//    func toBase64() -> String {
//        return Data(self.utf8).base64EncodedString()
//    }
//    
    func isContainsAlphabets() -> Bool {
        let letters = NSCharacterSet.letters
        let range = self.rangeOfCharacter(from: letters)
        return range != nil
    }
    func charAt(at: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: at)
        return self[charIndex]
    }
    
    func isBegin(with string:NSString) -> Bool {
        return self.hasPrefix(string as String) ? true : false
    }
    
    func isEnd(With string : NSString) -> Bool {
        return self.hasSuffix(string as String) ? true : false
    }
    //Chat date
    func getChatDateFromServer() -> String
       {
           let dateStr          = self
           let formatter        = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           let currDate : Date = formatter.date(from: dateStr)! as Date
           
           let todayDt = NSDate()
           let todaystr = formatter.string(from: todayDt as Date)
           let todaydate : Date = formatter.date(from: todaystr)! as Date
           
           
           if (todaydate >= currDate)
           {
               let startDate:NSDate = todaydate as NSDate
               let endDate:Date = currDate as Date
               
               let int_days = daysBetweenDates(startDate: startDate as Date,endDate: endDate)
               
               if int_days == -1
               {
                  return "Yesterday"
               }
               else if int_days == 0
               {
                  return ""
               }
               else if int_days < -1
               {
                  formatter.dateFormat = "dd MMM"
                  let todaystr1 = formatter.string(from: todayDt as Date)
                  return todaystr1
               }
               else
               {
                   return ""
               }
               
               
           }
           else
           {
               return ""
           }
       }

    func daysBetweenDates(startDate: Date , endDate: Date) -> Int {
           let calendar = Calendar.current
           
           let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
           
           return components.day!
       }
    
    public var isValidEmail: Bool {
        let regex : NSString = "^\\w+([\\.-]?\\w+)*\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{2,64}(\\.[a-zA-Z][a-zA-Z\\-]{2,25}|(([a-zA-Z\\-]+\\.)+[a-zA-Z]{2,3}))" // "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    /**
     Check email
     */
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    public var length: Int {
        return self.count
    }
    
    
    /**
     phone number
     */
    func isValidPhoneNumber() -> Bool {
        let regex : NSString = "[235689][0-9]{6}([0-9]{3})?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: self)
    }
    
    /**
     url
     */
   /* func getUserImageURL(url:String) -> URL {
       if length > 0 {
         if isValidUrl() {
           return URL(string: self)!
         }else {
           return URL(string: "\(url)\(self)")!
         }
       }
       return URL(string: "")!
     }*/
    func isValidUrl() -> Bool {
      //let regex : NSString = "^((http|https)?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$" //"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
       /* let regex : NSString = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
                    
      let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
      return predicate.evaluate(with: self)*/
        
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && self.count > 0) else { return false }
        if detector!.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) > 0 {
            return true
        }
        return false
    }
    
    
    func isValidPassword() -> Bool {
        let regex : NSString = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[#?!@$%.,_+|\\=</~>^({[)}]&*-]).{8,32}$" //"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&~^_-+/;':<>,.=|])[A-Za-z\\d@$!%*?&~^_-+/;':<>,.=|]{8,32}$"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: self)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    func statusisValid() -> Bool{
        self == "1"
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    func isContainsNumbers() -> Bool {
        let letters = NSCharacterSet.decimalDigits
        let range = self.rangeOfCharacter(from: letters)
        return range != nil
    }
    
    func isContainsWhiteSpace() -> Bool {
        let range = self.rangeOfCharacter(from: .whitespacesAndNewlines)
        return range != nil
    }
    
    func isContainsSpecialCharters() -> Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        let range = self.rangeOfCharacter(from: characterset.inverted)
        return range != nil
    }
//    func substring(_ startIndex: Int, length: Int) -> String {
//        let start = self.characters.index(self.startIndex, offsetBy: startIndex)
//        let end = self.characters.index(self.startIndex, offsetBy: startIndex + length)
//        return String(self[start..<end])
//    }
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

//Attributed text with Bullete


//public func add(stringList: [String],
//         font: UIFont,
//		 bulletfont: UIFont = UIFont(name: "Montserrat-Regular", size: 7.0)!,
//         bullet: String = "⬤",
//         indentation: CGFloat = 20,
//         lineSpacing: CGFloat = 2,
//         paragraphSpacing: CGFloat = 12,
//         textColor: UIColor = .gray,
//         bulletColor: UIColor = .gray,
//         forSingleNote : Bool = false) -> NSAttributedString {
//
//	let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
//	let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: bulletfont, NSAttributedString.Key.foregroundColor: bulletColor]
//
//    let paragraphStyle = NSMutableParagraphStyle()
//    let nonOptions = [NSTextTab.OptionKey: Any]()
//    paragraphStyle.tabStops = [
//        NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
//    paragraphStyle.defaultTabInterval = indentation
//    //paragraphStyle.firstLineHeadIndent = 0
//    //paragraphStyle.headIndent = 20
//    //paragraphStyle.tailIndent = 1
//    paragraphStyle.lineSpacing = lineSpacing
//    paragraphStyle.paragraphSpacing = paragraphSpacing
//    paragraphStyle.headIndent = indentation
//
//    let bulletList = NSMutableAttributedString()
//    for string in stringList {
//        var formattedString = ""
//        if stringList.last == string {
//            formattedString = "\(bullet)\t\(string)"
//        } else {
//            formattedString = "\(bullet)\t\(string)\n"
//        }
//        
//        let attributedString = NSMutableAttributedString(string: formattedString)
//
//        attributedString.addAttributes(
//			[NSAttributedString.Key.paragraphStyle : paragraphStyle],
//            range: NSMakeRange(0, attributedString.length))
//
//        attributedString.addAttributes(
//            textAttributes,
//            range: NSMakeRange(0, attributedString.length))
//
//        let string:NSString = NSString(string: formattedString)
//        let rangeForBullet:NSRange = string.range(of: bullet)
//        attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
//        bulletList.append(attributedString)
//    }
//    if forSingleNote
//    {
//        let noteStr = NSMutableAttributedString(string: "Note\n")
//        noteStr.addAttribute(NSAttributedString.Key.font, value: UIFont(name: fFONT_SEMIBOLD, size: 17.0)!, range: NSMakeRange(0, noteStr.length))
//        noteStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSMakeRange(0, noteStr.length))
//        noteStr.append(bulletList)
//        return noteStr
//    }
//    else
//    {
//        return bulletList
//    }
//}


/*
 Will generate radom string based on length
 */

public func randomString(length: Int) -> String {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    var randomString = ""
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    return randomString
}

public func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

extension Float{
    func getAmountInString() -> String{
        String(format: "\(CURRENCY_SYMBOL)%.2f", self)
    }
    func getroundedWith1Decimal() -> String{
        String(format: "%.1f", self)
    }
}
extension Double{
    func getAmountInString() -> String{
        String(format: "\(CURRENCY_SYMBOL)%.2f", self)
    }
    func getroundedWith1Decimal() -> String{
        String(format: "%.1f", self)
    }
}
extension Date
{

  func dateAt(hours: Int, minutes: Int) -> Date
  {
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!

    //get the month/day/year componentsfor today's date.


    var date_components = calendar.components(
      [NSCalendar.Unit.year,
       NSCalendar.Unit.month,
       NSCalendar.Unit.day],
      from: self)

    //Create an NSDate for the specified time today.
    date_components.hour = hours
    date_components.minute = minutes
    date_components.second = 0

    let newDate = calendar.date(from: date_components)!
    return newDate
  }
}
