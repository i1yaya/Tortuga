import Foundation
import UIKit

extension UIDevice {
  var iPhone: Bool {
    return UIDevice().userInterfaceIdiom == .phone
  }
  
  var iPad: Bool {
    return UIDevice().userInterfaceIdiom == .pad
  }
  
  enum ScreenType: String {
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXSMax
    case iPhone11
    case iPhone11Pro
    case iPhoneSE
    case iPhone12
    case iPhone12Pro
    case iPhone12Mini
    case iPhone14ProMax
    case iPadMini
    case iPadPro13
    case iPadPro11
    case iPadAir
    case Unknown
  }
  
  var model: ScreenType {
    
    if UIDevice().userInterfaceIdiom == .phone {
      guard iPhone else {
        return .Unknown
      }
    } else if UIDevice().userInterfaceIdiom == .pad {
      guard iPad else {
        return .Unknown
      }
    }
    
    switch UIScreen.main.nativeBounds.height {
    case 1136:
      return .iPhoneSE
    case 1334:
      return .iPhone8
    case 2208:
      return .iPhone8Plus
    case 2436:
      return .iPhoneX
    case 2521:
      return .iPhone12
    case 2532:
      return .iPhone11Pro
    case 2688:
      return .iPhoneXSMax
    case 2778:
      return .iPhone12Pro
    case 1792:
      return .iPhone11
    case 2266:
      return .iPadMini
    case 2732:
      return .iPadPro13
    case 2388:
      return .iPadPro11
    case 2360:
      return .iPadAir
    case 2796:
      return .iPhone14ProMax
    default:
      return .Unknown
    }
  }
}
