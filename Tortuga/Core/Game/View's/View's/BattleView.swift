import UIKit

class BattleView: UIView {
  private let device = UIDevice()
  
  public let background: UIImageView = {
    let image = UIImage(named: "BattleBackground")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let ground: UIImageView = {
    let image = UIImage(named: "BattleGround")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let cardDeck: UIImageView = {
    let image = UIImage(named: "HorizontalDeck")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let cardFromDeck: UIImageView = {
    let image = UIImage(named: "VerticalCard")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    return imageView
  }()
  
  public let cardLeftPlace: UIImageView = {
    let image = UIImage(named: "UnderVerticalCard")
    let imageView = UIImageView(image: image)
    imageView.layer.compositingFilter = "multiplyBlendMode"
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let cardRightPlace: UIImageView = {
    let image = UIImage(named: "UnderVerticalCard")
    let imageView = UIImageView(image: image)
    imageView.layer.compositingFilter = "multiplyBlendMode"
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let cardFromLeftPlace: UIImageView = {
    let image = UIImage(named: "UnderVerticalCard")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let cardFromRightPlace: UIImageView = {
    let image = UIImage(named: "UnderVerticalCard")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let cardTopPlace: UIImageView = {
    let image = UIImage(named: "UnderVerticalCard")
    let imageView = UIImageView(image: image)
    imageView.layer.compositingFilter = "multiplyBlendMode"
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let cardFromTop: UIImageView = {
    let image = UIImage(named: "VerticalCard")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    return imageView
  }()
  
  public let cardBottomPlace: UIButton = {
    let image = UIImage(named: "UnderVerticalCard")
    let imageView = UIButton()
    imageView.setBackgroundImage(image, for: .normal)
    imageView.layer.compositingFilter = "multiplyBlendMode"
    imageView.isEnabled = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let cardFromBottom: UIImageView = {
    let image = UIImage(named: "VerticalCard")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    return imageView
  }()
  
  public let topCounter: UIImageView = {
    let image = UIImage(named: "CardCounter")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let bottomCounter: UIImageView = {
    let image = UIImage(named: "CardCounter")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let topCount: UILabel = {
    let label = UILabel()
    label.text = "0"
    label.font = UIFont(name: "DEATH CROW DEMO", size: 28)
    label.textColor = #colorLiteral(red: 0.7607843137, green: 0.4941176471, blue: 0.2470588235, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  public let bottomCount: UILabel = {
    let label = UILabel()
    label.text = "0"
    label.font = UIFont(name: "DEATH CROW DEMO", size: 28)
    label.textColor = #colorLiteral(red: 0.7607843137, green: 0.4941176471, blue: 0.2470588235, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  public let pauseButton: UIButton = {
    let image = UIImage(named: "PauseButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isEnabled = false
    button.alpha = 0.5
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let balanceGround: UIImageView = {
    let image = UIImage(named: "CoinBalance")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let balanceLabel: UILabel = {
    let label = UILabel()
    label.text = "\(MainData.shared.coins)"
    label.font = UIFont(name: "Papyrus", size: 16)
    label.textColor = #colorLiteral(red: 0.4468473792, green: 0.3058497608, blue: 0.1608744562, alpha: 1)
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  public let betGround: UIImageView = {
    let image = UIImage(named: "BetGround")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let betLabel: UIImageView = {
    let image = UIImage(named: "BetLabel")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let betEdit: UIButton = {
    let image = UIImage(named: "MainNameEdit")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let betCount: UITextField = {
    let textField = UITextField()
    textField.text = "100"
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .clear
    textField.borderStyle = .none
    textField.font = UIFont(name: "Papyrus", size: 26)
    textField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    textField.textAlignment = .left
    textField.keyboardType = .numberPad
    textField.layer.cornerRadius = 15
    textField.tintColor = .clear
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  public let battle: UIImageView = {
    let image = UIImage(named: "Battle")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let result: UIImageView = {
    let image = UIImage(named: "WinScreen")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let winFrame: UIImageView = {
    let image = UIImage(named: "WinFrame")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let restartButton: UIButton = {
    let image = UIImage(named: "RestartButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let menuButton: UIButton = {
    let image = UIImage(named: "MenuButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let winCount: UILabel = {
    let label = UILabel()
    label.text = "2000"
    label.font = UIFont(name: "DEATH CROW DEMO", size: 32)
    label.textColor = #colorLiteral(red: 0.4468473792, green: 0.3058497608, blue: 0.1608744562, alpha: 1)
    label.textAlignment = .right
    label.isHidden = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    addSubview(background)
    addSubview(ground)
    addSubview(cardDeck)
    addSubview(cardLeftPlace)
    addSubview(cardRightPlace)
    addSubview(cardFromLeftPlace)
    addSubview(cardFromRightPlace)
    addSubview(cardTopPlace)
    addSubview(cardBottomPlace)
    addSubview(topCounter)
    addSubview(bottomCounter)
    addSubview(topCount)
    addSubview(bottomCount)
    addSubview(pauseButton)
    addSubview(balanceGround)
    addSubview(betGround)
    addSubview(betLabel)
    addSubview(betEdit)
    addSubview(balanceLabel)
    addSubview(betCount)
    addSubview(cardFromDeck)
    addSubview(cardFromTop)
    addSubview(cardFromBottom)
    addSubview(battle)
    addSubview(result)
    addSubview(menuButton)
    addSubview(restartButton)
    addSubview(winFrame)
    addSubview(winCount)
    
    if device.model == .iPhone8 {
      let constraints = [
        pauseButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
        pauseButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        cardBottomPlace.leftAnchor.constraint(equalTo: cardLeftPlace.centerXAnchor, constant: 5),
        cardBottomPlace.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
        
        ground.centerYAnchor.constraint(equalTo: centerYAnchor),
        ground.centerXAnchor.constraint(equalTo: centerXAnchor),
      ]
      NSLayoutConstraint.activate(constraints)
    } else if device.model == .iPhone8Plus || device.model == .iPhone11 || device.model == .iPhone14ProMax || device.model == .iPhone12Pro {
      let constraints = [
        pauseButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
        pauseButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        cardBottomPlace.leftAnchor.constraint(equalTo: cardLeftPlace.centerXAnchor, constant: 5),
        cardBottomPlace.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
        
        ground.topAnchor.constraint(equalTo: topAnchor),
        ground.bottomAnchor.constraint(equalTo: bottomAnchor),
        ground.centerXAnchor.constraint(equalTo: centerXAnchor),
      ]
      NSLayoutConstraint.activate(constraints)
    } else {
      let constraints = [
        pauseButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        pauseButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        cardBottomPlace.leftAnchor.constraint(equalTo: cardLeftPlace.centerXAnchor, constant: 5),
        cardBottomPlace.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        
        ground.centerYAnchor.constraint(equalTo: centerYAnchor),
        ground.centerXAnchor.constraint(equalTo: centerXAnchor),
      ]
      NSLayoutConstraint.activate(constraints)
    }
    
    let constraints = [
      background.rightAnchor.constraint(equalTo: rightAnchor),
      background.leftAnchor.constraint(equalTo: leftAnchor),
      background.topAnchor.constraint(equalTo: topAnchor),
      background.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      cardDeck.centerYAnchor.constraint(equalTo: centerYAnchor),
      cardDeck.rightAnchor.constraint(equalTo: centerXAnchor, constant: -75),
      
      cardFromDeck.centerYAnchor.constraint(equalTo: cardDeck.centerYAnchor),
      cardFromDeck.centerXAnchor.constraint(equalTo: cardDeck.centerXAnchor),
      
      cardLeftPlace.centerYAnchor.constraint(equalTo: centerYAnchor),
      cardLeftPlace.rightAnchor.constraint(equalTo: centerXAnchor, constant: 10),
      cardLeftPlace.heightAnchor.constraint(equalToConstant: 94),
      cardLeftPlace.widthAnchor.constraint(equalToConstant: 67),
      
      cardFromLeftPlace.centerYAnchor.constraint(equalTo: cardLeftPlace.centerYAnchor),
      cardFromLeftPlace.centerXAnchor.constraint(equalTo: cardLeftPlace.centerXAnchor),
      cardFromLeftPlace.heightAnchor.constraint(equalToConstant: 94),
      cardFromLeftPlace.widthAnchor.constraint(equalToConstant: 67),
      
      cardRightPlace.centerYAnchor.constraint(equalTo: centerYAnchor),
      cardRightPlace.leftAnchor.constraint(equalTo: centerXAnchor, constant: 20),
      cardRightPlace.heightAnchor.constraint(equalToConstant: 94),
      cardRightPlace.widthAnchor.constraint(equalToConstant: 67),
      
      cardFromRightPlace.centerYAnchor.constraint(equalTo: cardRightPlace.centerYAnchor),
      cardFromRightPlace.centerXAnchor.constraint(equalTo: cardRightPlace.centerXAnchor),
      cardFromRightPlace.heightAnchor.constraint(equalToConstant: 94),
      cardFromRightPlace.widthAnchor.constraint(equalToConstant: 67),
      
      cardTopPlace.leftAnchor.constraint(equalTo: cardLeftPlace.centerXAnchor, constant: 5),
      cardTopPlace.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -10),
      
      cardFromTop.centerYAnchor.constraint(equalTo: cardTopPlace.centerYAnchor),
      cardFromTop.centerXAnchor.constraint(equalTo: cardTopPlace.centerXAnchor),
      
      cardFromBottom.centerYAnchor.constraint(equalTo: cardBottomPlace.centerYAnchor),
      cardFromBottom.centerXAnchor.constraint(equalTo: cardBottomPlace.centerXAnchor),
      
      topCounter.rightAnchor.constraint(equalTo: cardTopPlace.leftAnchor, constant: -25),
      topCounter.centerYAnchor.constraint(equalTo: cardTopPlace.centerYAnchor),
      
      bottomCounter.rightAnchor.constraint(equalTo: cardBottomPlace.leftAnchor, constant: -25),
      bottomCounter.centerYAnchor.constraint(equalTo: cardBottomPlace.centerYAnchor),
      
      topCount.centerXAnchor.constraint(equalTo: topCounter.centerXAnchor),
      topCount.centerYAnchor.constraint(equalTo: topCounter.centerYAnchor),
      
      bottomCount.centerXAnchor.constraint(equalTo: bottomCounter.centerXAnchor),
      bottomCount.centerYAnchor.constraint(equalTo: bottomCounter.centerYAnchor),
      
      balanceGround.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
      balanceGround.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      
      betGround.centerYAnchor.constraint(equalTo: centerYAnchor),
      betGround.leftAnchor.constraint(equalTo: centerXAnchor, constant: 125),
      
      betLabel.leftAnchor.constraint(equalTo: betGround.leftAnchor, constant: 15),
      betLabel.bottomAnchor.constraint(equalTo: betGround.topAnchor, constant: 15),
      
      betEdit.centerYAnchor.constraint(equalTo: betLabel.centerYAnchor),
      betEdit.rightAnchor.constraint(equalTo: betGround.rightAnchor, constant: -35),
      
      balanceLabel.rightAnchor.constraint(equalTo: balanceGround.rightAnchor, constant: -25),
      balanceLabel.centerYAnchor.constraint(equalTo: balanceGround.centerYAnchor),
      
      betCount.leftAnchor.constraint(equalTo: betGround.leftAnchor, constant: 35),
      betCount.centerYAnchor.constraint(equalTo: betGround.centerYAnchor),
      betCount.heightAnchor.constraint(equalToConstant: 50),
      betCount.widthAnchor.constraint(equalToConstant: 75),
      
      battle.centerXAnchor.constraint(equalTo: centerXAnchor),
      battle.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      result.rightAnchor.constraint(equalTo: rightAnchor),
      result.leftAnchor.constraint(equalTo: leftAnchor),
      result.topAnchor.constraint(equalTo: topAnchor),
      result.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      menuButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      menuButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      restartButton.bottomAnchor.constraint(equalTo: menuButton.topAnchor, constant: 35),
      restartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      winFrame.bottomAnchor.constraint(equalTo: menuButton.topAnchor, constant: 30),
      winFrame.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      winCount.centerYAnchor.constraint(equalTo: winFrame.centerYAnchor),
      winCount.rightAnchor.constraint(equalTo: winFrame.centerXAnchor, constant: 25)
    ]
    NSLayoutConstraint.activate(constraints)
  }
}
