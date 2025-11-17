import Foundation

class YatzyData {
  static let shared = YatzyData()
  
  var yatzyBet: Int = 1000
  var turn: TurnType = .player
}

enum TurnType {
  case player, enemy
}
