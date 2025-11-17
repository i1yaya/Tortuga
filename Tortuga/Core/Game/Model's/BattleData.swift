import Foundation

struct Card {
  var cardNumber: Int
  var cardType: Int
}

class BattleData {
  static let shared = BattleData()
  
  var topCount: Int = 0
  var bottomCount: Int = 0
  var battleBet: Int = 1000
}
