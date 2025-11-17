import UIKit
import SpriteKit
import GameplayKit

class BattleViewController: UIViewController {
  private var battleView: BattleView!
  private var pauseView: PauseView!
  
  private var cards: [Card] = []
  private var battleCards: [Card] = []
  
  private var topCards: [Card] = []
  private var bottomCards: [Card] = []
  
  private var battle: Bool = false
  private var afterBattle: Bool = false
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupBalance()
    setupStartBet()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupController()
    setupView()
    setupPause()
    
    setupTargets()
    setupDelegate()
    
    if battleView.betCount.text != nil && Int(battleView.betCount.text!) != nil {
      if MainData.shared.coins > 0 && Int(battleView.betCount.text!)! != 0 {
        startGame()
        setupCardDeck()
        
        setupBalance()
        setupStartBet()
        
        animateBattle(entrySize: 0.1, entryDuration: 0.01)
        animateResult(entrySize: 0.1, entryDuration: 0.01)
      } else {
        battleView.pauseButton.isEnabled = true
        battleView.pauseButton.alpha = 1
      }
    }
  }
  
  private func setupController() {
    navigationItem.hidesBackButton = true
  }
  
  private func setupView() {
    battleView = BattleView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    battleView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(battleView)
    
    let constraints = [
      battleView.leftAnchor.constraint(equalTo: view.leftAnchor),
      battleView.rightAnchor.constraint(equalTo: view.rightAnchor),
      battleView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      battleView.topAnchor.constraint(equalTo: view.topAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
  }
  
  private func setupPause() {
    pauseView = PauseView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    pauseView.translatesAutoresizingMaskIntoConstraints = false
    pauseView.isHidden = true
    
    view.addSubview(pauseView)
    
    let constraints = [
      pauseView.leftAnchor.constraint(equalTo: view.leftAnchor),
      pauseView.rightAnchor.constraint(equalTo: view.rightAnchor),
      pauseView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      pauseView.topAnchor.constraint(equalTo: view.topAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
  }
  
  private func setupTargets() {
    battleView.cardBottomPlace.addTarget(self, action: #selector(dropCard), for: .touchUpInside)
    battleView.menuButton.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
    battleView.restartButton.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
    battleView.pauseButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
    pauseView.resumeButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
    pauseView.replayButton.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
    pauseView.menuButton.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
    battleView.betEdit.addTarget(self, action: #selector(setupBet), for: .touchUpInside)
  }
  
  @objc func setupBet() {
    for _ in 0...1 {
      battleView.betCount.isEnabled.toggle()
    }
  }
  
  @objc func pauseAction() {
    pauseView.isHidden.toggle()
  }
  
  @objc func menuAction() {
    cards = []
    topCards = []
    bottomCards = []
    BattleData.shared.battleBet = 1000
    BattleData.shared.topCount = 0
    BattleData.shared.bottomCount = 0
    navigationController?.popViewController(animated: true)
  }
  
  @objc func restartAction() {
    cards = []
    topCards = []
    bottomCards = []
    BattleData.shared.battleBet = 1000
    BattleData.shared.topCount = 0
    BattleData.shared.bottomCount = 0
    viewDidLoad()
  }
  
  @objc func dropCard() {
    if battleView.betCount.text != nil && Int(battleView.betCount.text!) != nil {
      if Int(battleView.betCount.text!)! != 0 {
        if topCards.count > 0 && bottomCards.count > 0 {
          animateBottomCard()
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.enemyDropCard()
          }
          
          if bottomCards.count < 13 {
            battleView.cardBottomPlace.setBackgroundImage(UIImage(named: "VerticalCard"), for: .normal)
          }
          
          if bottomCards.count == 1 {
            battleView.cardBottomPlace.setBackgroundImage(UIImage(named: "UnderVerticalCard"), for: .normal)
            battleView.cardBottomPlace.layer.compositingFilter = "multiplyBlendMode"
          }
        } else {
          print("end game")
        }
        
        if battleView.betCount.isEnabled == true {
          battleView.betCount.isEnabled = false
          
          getBet()
        }
      }
    }
  }
  
  @objc func enemyDropCard() {
    animateTopCard()
    
    if topCards.count < 13 {
      battleView.cardTopPlace.image = UIImage(named: "VerticalCard")
    }
    
    if topCards.count == 1 {
      battleView.cardTopPlace.image = UIImage(named: "UnderVerticalCard")
      battleView.cardTopPlace.layer.compositingFilter = "multiplyBlendMode"
    }
  }
  
  private func checkCard() {
    if topCards[0].cardNumber > bottomCards[0].cardNumber {
      if afterBattle {
        for card in battleCards {
          bottomCards.append(card)
        }
        battleCards = []
        afterBattle = false
      }
      topCards.append(topCards[0])
      topCards.remove(at: 0)
      
      topCards.append(bottomCards[0])
      bottomCards.remove(at: 0)
      
      battleView.topCount.text = "\(topCards.count)"
      battleView.bottomCount.text = "\(bottomCards.count)"
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
        self?.animateTopTakeCard()
      }
    } else if bottomCards[0].cardNumber > topCards[0].cardNumber {
      if afterBattle {
        for card in battleCards {
          bottomCards.append(card)
        }
        battleCards = []
        afterBattle = false
      }
      bottomCards.append(bottomCards[0])
      bottomCards.remove(at: 0)
      
      bottomCards.append(topCards[0])
      topCards.remove(at: 0)
      
      battleView.topCount.text = "\(topCards.count)"
      battleView.bottomCount.text = "\(bottomCards.count)"
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
        self?.animateBottomTakeCard()
      }
    } else if bottomCards[0].cardNumber == topCards[0].cardNumber {
      if bottomCards.count >= 3 && topCards.count >= 3 {
        battle = true
        
        battleView.battle.isHidden = false
        animateBattle(entrySize: 10, entryDuration: 1.5)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
          self?.animateBattle(entrySize: 0.1, entryDuration: 1.5)
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.battleView.battle.isHidden = true
            self?.battleView.cardBottomPlace.isEnabled = true
          }
        }
        
        battleCards.append(bottomCards[0])
        battleCards.append(topCards[0])
        
        bottomCards.remove(at: 0)
        topCards.remove(at: 0)
        
        battleView.topCount.text = "\(topCards.count)"
        battleView.bottomCount.text = "\(bottomCards.count)"
      } else {
        let random = Int.random(in: 0...1)
        if random == 0 {
          if afterBattle {
            for card in battleCards {
              bottomCards.append(card)
            }
            battleCards = []
            afterBattle = false
          }
          topCards.append(topCards[0])
          topCards.remove(at: 0)
          
          topCards.append(bottomCards[0])
          bottomCards.remove(at: 0)
          
          battleView.topCount.text = "\(topCards.count)"
          battleView.bottomCount.text = "\(bottomCards.count)"
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
            self?.animateTopTakeCard()
          }
        } else if random == 1 {
          if afterBattle {
            for card in battleCards {
              bottomCards.append(card)
            }
            battleCards = []
            afterBattle = false
          }
          bottomCards.append(bottomCards[0])
          bottomCards.remove(at: 0)
          
          bottomCards.append(topCards[0])
          topCards.remove(at: 0)
          
          battleView.topCount.text = "\(topCards.count)"
          battleView.bottomCount.text = "\(bottomCards.count)"
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
            self?.animateBottomTakeCard()
          }
        }
      }
    }
    
    if bottomCards.count == 0 || topCards.count == 0 {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.25) { [weak self] in
        self?.checkResult()
      }
    }
  }
  
  private func setupDelegate() {
    battleView.betCount.delegate = self
  }
  
  private func startGame() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      self?.animateCards()
    }
  }
  
  private func animateCards() {
    if BattleData.shared.topCount <= 25 {
      battleView.cardFromDeck.isHidden = false
      
      let originalTransform = battleView.cardFromDeck.transform
      let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 150, y: -120)
      UIView.animate(withDuration: 0.25, animations: {
        self.battleView.cardFromDeck.transform = scaledAndTranslatedTransform
      })
      
      setupTopCards(cardNumber: Int.random(in: 0...51))
      BattleData.shared.topCount += 1
      SoundPlayer.shared.cardSound()
      battleView.topCount.text = "\(BattleData.shared.topCount)"
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.26) { [weak self] in
        if BattleData.shared.topCount > 13 {
          self?.battleView.cardTopPlace.image = UIImage(named: "VerticalDeck")
        } else {
          self?.battleView.cardTopPlace.image = UIImage(named: "VerticalCard")
        }
        self?.battleView.cardTopPlace.layer.compositingFilter = .none
        self?.battleView.cardFromDeck.isHidden = true
        
        if self?.battleView.cardFromDeck.transform != nil {
          let originalTransform = self!.battleView.cardFromDeck.transform
          let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
          let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -150, y: 120)
          UIView.animate(withDuration: 0.01, animations: {
            self?.battleView.cardFromDeck.transform = scaledAndTranslatedTransform
          })
        }
        self?.animateCards()
      }
    } else if BattleData.shared.bottomCount <= 24 {
      if BattleData.shared.bottomCount >= 13 {
        battleView.cardDeck.image = UIImage(named: "HorizontalCard")
      }
      
      battleView.cardFromDeck.isHidden = false
      
      let originalTransform = battleView.cardFromDeck.transform
      let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 150, y: 130)
      UIView.animate(withDuration: 0.25, animations: {
        self.battleView.cardFromDeck.transform = scaledAndTranslatedTransform
      })
      
      setupBottomCards(cardNumber: Int.random(in: 0...51))
      BattleData.shared.bottomCount += 1
      SoundPlayer.shared.cardSound()
      battleView.bottomCount.text = "\(BattleData.shared.bottomCount)"
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.26) { [weak self] in
        if BattleData.shared.bottomCount > 13 {
          self?.battleView.cardBottomPlace.setBackgroundImage(UIImage(named: "VerticalDeck"), for: .normal)
        } else {
          self?.battleView.cardBottomPlace.setBackgroundImage(UIImage(named: "VerticalCard"), for: .normal)
        }
        self?.battleView.cardBottomPlace.layer.compositingFilter = .none
        self?.battleView.cardFromDeck.isHidden = true
        
        if self?.battleView.cardFromDeck.transform != nil {
          let originalTransform = self!.battleView.cardFromDeck.transform
          let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
          let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -150, y: -130)
          UIView.animate(withDuration: 0.01, animations: {
            self?.battleView.cardFromDeck.transform = scaledAndTranslatedTransform
          })
        }
        self?.animateCards()
      }
    } else if BattleData.shared.bottomCount == 25 {
      battleView.cardFromDeck.isHidden = false
      
      let originalTransform = battleView.cardFromDeck.transform
      let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 150, y: 130)
      UIView.animate(withDuration: 0.25, animations: {
        self.battleView.cardFromDeck.transform = scaledAndTranslatedTransform
      })
      
      setupBottomCards(cardNumber: Int.random(in: 0...51))
      BattleData.shared.bottomCount += 1
      SoundPlayer.shared.cardSound()
      battleView.bottomCount.text = "\(BattleData.shared.bottomCount)"
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.26) { [weak self] in
        if BattleData.shared.bottomCount > 13 {
          self?.battleView.cardBottomPlace.setBackgroundImage(UIImage(named: "VerticalDeck"), for: .normal)
        } else {
          self?.battleView.cardBottomPlace.setBackgroundImage(UIImage(named: "VerticalCard"), for: .normal)
        }
        self?.battleView.cardBottomPlace.layer.compositingFilter = .none
        self?.battleView.cardFromDeck.isHidden = true
        
        if self?.battleView.cardFromDeck.transform != nil {
          let originalTransform = self!.battleView.cardFromDeck.transform
          let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
          let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -150, y: -130)
          UIView.animate(withDuration: 0.01, animations: {
            self?.battleView.cardFromDeck.transform = scaledAndTranslatedTransform
          })
        }
        self?.animateCards()
      }
      
      battleView.cardDeck.image = UIImage(named: "UnderHorizontalCard")
      battleView.cardDeck.layer.compositingFilter = "multiplyBlendMode"
      
      battleView.pauseButton.isEnabled = true
      battleView.pauseButton.alpha = 1
      battleView.cardBottomPlace.isEnabled = true
    }
  }
  
  private func setupCardDeck() {
    for i in 2...14 {
      for j in 0...3 {
        cards.append(Card(cardNumber: i, cardType: j))
      }
    }
  }
  
  private func setupTopCards(cardNumber: Int) {
    if cards[cardNumber].cardNumber != 0 && topCards.count <= 25 {
      topCards.append(cards[cardNumber])
      cards[cardNumber].cardNumber = 0
    } else {
      setupTopCards(cardNumber: Int.random(in: 0...51))
    }
  }
  
  private func setupBottomCards(cardNumber: Int) {
    if cards[cardNumber].cardNumber != 0 && bottomCards.count <= 25 {
      bottomCards.append(cards[cardNumber])
      cards[cardNumber].cardNumber = 0
    } else {
      setupBottomCards(cardNumber: Int.random(in: 0...51))
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  private func setupBalance() {
    if MainData.shared.coins / 1000 > 0 {
      let thousands = MainData.shared.coins / 1000
      let coins = MainData.shared.coins - (thousands * 1000)
      if coins < 10 {
        battleView.balanceLabel.text = "\(thousands) 00\(coins)"
      } else if coins < 100 {
        battleView.balanceLabel.text = "\(thousands) 0\(coins)"
      } else {
        battleView.balanceLabel.text = "\(thousands) \(coins)"
      }
    } else {
      battleView.balanceLabel.text = "\(MainData.shared.coins)"
    }
  }
  
  private func setupStartBet() {
    if MainData.shared.coins < 100 {
      battleView.betCount.text = "\(MainData.shared.coins)"
    } else {
      battleView.betCount.text = "100"
    }
  }
  
  private func getBet() {
    if battleView.betCount.text != nil && Int(battleView.betCount.text!) != nil {
      BattleData.shared.battleBet = Int(battleView.betCount.text!)!
      
      MainData.shared.coins -= BattleData.shared.battleBet
      setupBalance()
    }
    UserDefaults.standard.set(MainData.shared.coins, forKey: "coin")
    battleView.betGround.alpha = 0.5
    battleView.betCount.alpha = 0.5
  }
  
  private func animateBottomCard() {
    SoundPlayer.shared.cardSound()
    if battle {
      battleView.cardFromBottom.isHidden = false
      
      let originalTransform = battleView.cardFromBottom.transform
      let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -45.5, y: -117.4)
      battleView.cardBottomPlace.isEnabled = false
      UIView.animate(withDuration: 0.25, animations: {
        self.battleView.cardFromBottom.transform = scaledAndTranslatedTransform
      })
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
        self?.battleView.cardFromBottom.isHidden = true
        
        if self?.battleView.cardFromBottom.transform != nil {
          let originalTransform = self!.battleView.cardFromBottom.transform
          let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
          let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 45.5, y: 117.4)
          UIView.animate(withDuration: 0.01, animations: {
            self?.battleView.cardFromBottom.transform = scaledAndTranslatedTransform
          })
        }
        
        self?.battleView.cardLeftPlace.image = UIImage(named: "VerticalCard")
        self?.battleView.cardLeftPlace.layer.compositingFilter = .none
      }
    } else {
      battleView.cardFromBottom.isHidden = false
      
      let originalTransform = battleView.cardFromBottom.transform
      let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -45.5, y: -117.4)
      battleView.cardBottomPlace.isEnabled = false
      UIView.animate(withDuration: 0.25, animations: {
        self.battleView.cardFromBottom.transform = scaledAndTranslatedTransform
      })
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
        self?.battleView.cardFromBottom.isHidden = true
        
        if self?.battleView.cardFromBottom.transform != nil {
          let originalTransform = self!.battleView.cardFromBottom.transform
          let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
          let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 45.5, y: 117.4)
          UIView.animate(withDuration: 0.01, animations: {
            self?.battleView.cardFromBottom.transform = scaledAndTranslatedTransform
          })
        }
        
        self?.battleView.cardLeftPlace.image = UIImage(named: "\(self!.bottomCards[0].cardNumber)_\(self!.bottomCards[0].cardType)")
        self?.battleView.cardLeftPlace.layer.compositingFilter = .none
      }
    }
  }
  
  private func animateTopCard() {
    SoundPlayer.shared.cardSound()
    if battle {
      battleView.cardFromTop.isHidden = false
      
      let originalTransform = battleView.cardFromTop.transform
      let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 31.5, y: 116.6)
      UIView.animate(withDuration: 0.25, animations: {
        self.battleView.cardFromTop.transform = scaledAndTranslatedTransform
      })
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
        self?.battleView.cardFromTop.isHidden = true
        
        if self?.battleView.cardFromTop.transform != nil {
          let originalTransform = self!.battleView.cardFromTop.transform
          let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
          let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -31.5, y: -116.6)
          UIView.animate(withDuration: 0.01, animations: {
            self?.battleView.cardFromTop.transform = scaledAndTranslatedTransform
          })
        }
        
        self?.battleView.cardRightPlace.image = UIImage(named: "VerticalCard")
        self?.battleView.cardRightPlace.layer.compositingFilter = .none
        
        self?.battleCards.append(self!.bottomCards[0])
        self?.battleCards.append(self!.topCards[0])
        
        self?.bottomCards.remove(at: 0)
        self?.topCards.remove(at: 0)
        
        self?.battle = false
        self?.afterBattle = true
        
        self?.battleView.cardBottomPlace.isEnabled = true
      }
    } else {
      battleView.cardFromTop.isHidden = false
      
      let originalTransform = battleView.cardFromTop.transform
      let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 31.5, y: 116.6)
      UIView.animate(withDuration: 0.25, animations: {
        self.battleView.cardFromTop.transform = scaledAndTranslatedTransform
      })
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
        self?.battleView.cardFromTop.isHidden = true
        
        if self?.battleView.cardFromTop.transform != nil {
          let originalTransform = self!.battleView.cardFromTop.transform
          let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
          let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -31.5, y: -116.6)
          UIView.animate(withDuration: 0.01, animations: {
            self?.battleView.cardFromTop.transform = scaledAndTranslatedTransform
          })
        }
        
        self?.battleView.cardRightPlace.image = UIImage(named: "\(self!.topCards[0].cardNumber)_\(self!.topCards[0].cardType)")
        self?.battleView.cardRightPlace.layer.compositingFilter = .none
        
        self?.checkCard()
      }
    }
  }
  
  private func animateBottomTakeCard() {
    SoundPlayer.shared.cardSound()
    battleView.cardFromLeftPlace.isHidden = false
    battleView.cardFromRightPlace.isHidden = false
    
    battleView.cardFromLeftPlace.image = battleView.cardLeftPlace.image
    battleView.cardFromRightPlace.image = battleView.cardRightPlace.image
    
    battleView.cardLeftPlace.image = UIImage(named: "UnderVerticalCard")
    battleView.cardLeftPlace.layer.compositingFilter = "multiplyBlendMode"
    battleView.cardRightPlace.image = UIImage(named: "UnderVerticalCard")
    battleView.cardRightPlace.layer.compositingFilter = "multiplyBlendMode"
    
    var originalTransform = battleView.cardFromLeftPlace.transform
    var scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
    var scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 40, y: 100)
    UIView.animate(withDuration: 0.25, animations: {
      self.battleView.cardFromLeftPlace.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = battleView.cardFromRightPlace.transform
    scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -40, y: 100)
    UIView.animate(withDuration: 0.25, animations: {
      self.battleView.cardFromRightPlace.transform = scaledAndTranslatedTransform
    })
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.26) { [weak self] in
      self?.battleView.cardBottomPlace.isEnabled = true
      
      self?.battleView.cardFromLeftPlace.isHidden = true
      self?.battleView.cardFromRightPlace.isHidden = true
      
      if self?.battleView.cardFromLeftPlace.transform != nil {
        let originalTransform = self!.battleView.cardFromLeftPlace.transform
        let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -40, y: -100)
        UIView.animate(withDuration: 0.01, animations: {
          self?.battleView.cardFromLeftPlace.transform = scaledAndTranslatedTransform
        })
      }
      
      if self?.battleView.cardFromRightPlace.transform != nil {
        originalTransform = self!.battleView.cardFromRightPlace.transform
        scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
        scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 40, y: -100)
        UIView.animate(withDuration: 0.01, animations: {
          self?.battleView.cardFromRightPlace.transform = scaledAndTranslatedTransform
        })
      }
    }
  }
  
  private func animateTopTakeCard() {
    SoundPlayer.shared.cardSound()
    battleView.cardFromLeftPlace.isHidden = false
    battleView.cardFromRightPlace.isHidden = false
    
    battleView.cardFromLeftPlace.image = battleView.cardLeftPlace.image
    battleView.cardFromRightPlace.image = battleView.cardRightPlace.image
    
    battleView.cardLeftPlace.image = UIImage(named: "UnderVerticalCard")
    battleView.cardLeftPlace.layer.compositingFilter = "multiplyBlendMode"
    battleView.cardRightPlace.image = UIImage(named: "UnderVerticalCard")
    battleView.cardRightPlace.layer.compositingFilter = "multiplyBlendMode"
    
    var originalTransform = battleView.cardFromLeftPlace.transform
    var scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
    var scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 40, y: -100)
    UIView.animate(withDuration: 0.25, animations: {
      self.battleView.cardFromLeftPlace.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = battleView.cardFromRightPlace.transform
    scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -40, y: -100)
    UIView.animate(withDuration: 0.25, animations: {
      self.battleView.cardFromRightPlace.transform = scaledAndTranslatedTransform
    })
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.26) { [weak self] in
      self?.battleView.cardBottomPlace.isEnabled = true
      
      self?.battleView.cardFromLeftPlace.isHidden = true
      self?.battleView.cardFromRightPlace.isHidden = true
      
      if self?.battleView.cardFromLeftPlace.transform != nil {
        let originalTransform = self!.battleView.cardFromLeftPlace.transform
        let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: -40, y: 100)
        UIView.animate(withDuration: 0.01, animations: {
          self?.battleView.cardFromLeftPlace.transform = scaledAndTranslatedTransform
        })
      }
      
      if self?.battleView.cardFromRightPlace.transform != nil {
        originalTransform = self!.battleView.cardFromRightPlace.transform
        scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
        scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 40, y: 100)
        UIView.animate(withDuration: 0.01, animations: {
          self?.battleView.cardFromRightPlace.transform = scaledAndTranslatedTransform
        })
      }
    }
  }
  
  private func animateBattle(entrySize: CGFloat, entryDuration: Double) {
    let originalTransform = battleView.battle.transform
    let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.battleView.battle.transform = scaledAndTranslatedTransform
    })
  }
  
  private func checkResult() {
    if topCards.count == 0 {
      battleView.result.isHidden = false
      battleView.result.image = UIImage(named: "WinScreen")
      battleView.menuButton.isHidden = false
      battleView.menuButton.setBackgroundImage(UIImage(named: "CollectButton"), for: .normal)
      battleView.winFrame.isHidden = false
      battleView.winFrame.image = UIImage(named: "WinFrame")
      battleView.winCount.text = "\(BattleData.shared.battleBet * 2)"
      battleView.winCount.isHidden = false
      
      MainData.shared.coins += BattleData.shared.battleBet * 2
    } else if bottomCards.count == 0 {
      battleView.result.isHidden = false
      battleView.result.image = UIImage(named: "LoseScreen")
      battleView.menuButton.isHidden = false
      battleView.menuButton.setBackgroundImage(UIImage(named: "MenuButton"), for: .normal)
      battleView.restartButton.isHidden = false
      battleView.restartButton.setBackgroundImage(UIImage(named: "RestartButton"), for: .normal)
    }
    
    animateResult(entrySize: 10, entryDuration: 1.5)
    UserDefaults.standard.set(MainData.shared.coins, forKey: "coin")
  }
  
  private func animateResult(entrySize: CGFloat, entryDuration: Double) {
    var originalTransform = battleView.menuButton.transform
    var scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    var scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.battleView.menuButton.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = battleView.winFrame.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.battleView.winFrame.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = battleView.restartButton.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.battleView.restartButton.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = battleView.winCount.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.battleView.winCount.transform = scaledAndTranslatedTransform
    })
  }
}

extension BattleViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField.text != nil {
      var count: Int?
      count = Int(textField.text!)
      
      if count != nil {
        if count! > MainData.shared.coins {
          count = MainData.shared.coins
          textField.text = "\(count!)"
        }
        
        BattleData.shared.battleBet = count!
      } else {
        count = 1
        textField.text = "\(count!)"
        
        BattleData.shared.battleBet = count!
      }
    }
  }
}
