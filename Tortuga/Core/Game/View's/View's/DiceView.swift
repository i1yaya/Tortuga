import UIKit

class DiceView: UIView {
  public let background: UIImageView = {
    let image = UIImage(named: "DiceBackground")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let ground: UIImageView = {
    let image = UIImage(named: "PauseBackground")
    let imageView = UIImageView(image: image)
    imageView.alpha = 0.5
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let pauseButton: UIButton = {
    let image = UIImage(named: "PauseButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
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
    label.text = "27 500"
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
    textField.text = "1000"
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
  
  public let cup0: UIImageView = {
    let image = UIImage(named: "DiceCup")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let rollButton: UIButton = {
    let image = UIImage(named: "DiceRollButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let bidGround: UIImageView = {
    let image = UIImage(named: "DiceGround")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let bidButton: UIButton = {
    let image = UIImage(named: "BidButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let countGround: UIImageView = {
    let image = UIImage(named: "UnderDice")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.layer.compositingFilter = "multiplyBlendMode"
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let cubeGround: UIImageView = {
    let image = UIImage(named: "UnderDice")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.layer.compositingFilter = "multiplyBlendMode"
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let cubeUpButton: UIButton = {
    let image = UIImage(named: "DiceUp")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let cubeDownButton: UIButton = {
    let image = UIImage(named: "DiceDown")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let countUpButton: UIButton = {
    let image = UIImage(named: "DiceUp")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let countDownButton: UIButton = {
    let image = UIImage(named: "DiceDown")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let cube: UIImageView = {
    let image = UIImage(named: "Cube0")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let count: UILabel = {
    let label = UILabel()
    label.text = "1"
    label.font = UIFont(name: "DEATH CROW DEMO", size: 38)
    label.textColor = #colorLiteral(red: 0.9868989426, green: 0.6528094444, blue: 0.1398208843, alpha: 1)
    label.textAlignment = .center
    label.isHidden = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  public let cube0: UIButton = {
    let image = UIImage(named: "Cube0")
    let imageView = UIButton()
    imageView.setBackgroundImage(image, for: .normal)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    return imageView
  }()
  
  public let cube1: UIButton = {
    let image = UIImage(named: "Cube0")
    let imageView = UIButton()
    imageView.setBackgroundImage(image, for: .normal)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    return imageView
  }()
  
  public let cube2: UIButton = {
    let image = UIImage(named: "Cube0")
    let imageView = UIButton()
    imageView.setBackgroundImage(image, for: .normal)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    return imageView
  }()
  
  public let cube3: UIButton = {
    let image = UIImage(named: "Cube0")
    let imageView = UIButton()
    imageView.setBackgroundImage(image, for: .normal)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    return imageView
  }()
  
  public let cube4: UIButton = {
    let image = UIImage(named: "Cube0")
    let imageView = UIButton()
    imageView.setBackgroundImage(image, for: .normal)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
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
    addSubview(pauseButton)
    addSubview(cup0)
    addSubview(cube0)
    addSubview(cube1)
    addSubview(cube2)
    addSubview(cube3)
    addSubview(cube4)
    addSubview(balanceGround)
    addSubview(betGround)
    addSubview(betLabel)
    addSubview(betEdit)
    addSubview(balanceLabel)
    addSubview(betCount)
    addSubview(rollButton)
    addSubview(ground)
    addSubview(bidGround)
    addSubview(bidButton)
    addSubview(countGround)
    addSubview(cubeGround)
    addSubview(cubeUpButton)
    addSubview(cubeDownButton)
    addSubview(countUpButton)
    addSubview(countDownButton)
    addSubview(cube)
    addSubview(count)
    addSubview(result)
    addSubview(menuButton)
    addSubview(restartButton)
    addSubview(winFrame)
    addSubview(winCount)
    
    let constraints = [
      background.rightAnchor.constraint(equalTo: rightAnchor),
      background.leftAnchor.constraint(equalTo: leftAnchor),
      background.topAnchor.constraint(equalTo: topAnchor),
      background.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      pauseButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
      pauseButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      
      balanceGround.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
      balanceGround.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      
      betGround.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      betGround.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
      
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
      
      cup0.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25),
      cup0.rightAnchor.constraint(equalTo: centerXAnchor, constant: -25),
      
      rollButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      rollButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      ground.rightAnchor.constraint(equalTo: rightAnchor),
      ground.leftAnchor.constraint(equalTo: leftAnchor),
      ground.topAnchor.constraint(equalTo: topAnchor),
      ground.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      bidGround.centerYAnchor.constraint(equalTo: centerYAnchor),
      bidGround.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      bidButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      bidButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      cubeGround.centerYAnchor.constraint(equalTo: bidGround.centerYAnchor, constant: 10),
      cubeGround.leftAnchor.constraint(equalTo: bidGround.centerXAnchor, constant: 10),
      
      countGround.centerYAnchor.constraint(equalTo: bidGround.centerYAnchor, constant: 10),
      countGround.rightAnchor.constraint(equalTo: bidGround.centerXAnchor, constant: -10),
      
      cubeUpButton.centerXAnchor.constraint(equalTo: cubeGround.centerXAnchor),
      cubeUpButton.bottomAnchor.constraint(equalTo: cubeGround.topAnchor, constant: -10),
      
      cubeDownButton.centerXAnchor.constraint(equalTo: cubeGround.centerXAnchor),
      cubeDownButton.topAnchor.constraint(equalTo: cubeGround.bottomAnchor, constant: 10),
      
      countUpButton.centerXAnchor.constraint(equalTo: countGround.centerXAnchor),
      countUpButton.bottomAnchor.constraint(equalTo: countGround.topAnchor, constant: -10),
      
      countDownButton.centerXAnchor.constraint(equalTo: countGround.centerXAnchor),
      countDownButton.topAnchor.constraint(equalTo: countGround.bottomAnchor, constant: 10),
      
      cube.centerXAnchor.constraint(equalTo: cubeGround.centerXAnchor),
      cube.centerYAnchor.constraint(equalTo: cubeGround.centerYAnchor),
      cube.heightAnchor.constraint(equalToConstant: 50),
      cube.widthAnchor.constraint(equalToConstant: 50),
      
      count.centerXAnchor.constraint(equalTo: countGround.centerXAnchor),
      count.centerYAnchor.constraint(equalTo: countGround.centerYAnchor),
      
      cube2.centerXAnchor.constraint(equalTo: cup0.centerXAnchor),
      cube2.topAnchor.constraint(equalTo: cup0.topAnchor, constant: 175),
      cube2.heightAnchor.constraint(equalToConstant: 60),
      cube2.widthAnchor.constraint(equalToConstant: 60),
      
      cube1.rightAnchor.constraint(equalTo: cube2.leftAnchor, constant: -5),
      cube1.topAnchor.constraint(equalTo: cup0.topAnchor, constant: 150),
      cube1.heightAnchor.constraint(equalToConstant: 60),
      cube1.widthAnchor.constraint(equalToConstant: 60),
      
      cube0.rightAnchor.constraint(equalTo: cube1.leftAnchor),
      cube0.topAnchor.constraint(equalTo: cup0.topAnchor, constant: 175),
      cube0.heightAnchor.constraint(equalToConstant: 60),
      cube0.widthAnchor.constraint(equalToConstant: 60),
      
      cube3.leftAnchor.constraint(equalTo: cube2.rightAnchor, constant: 5),
      cube3.topAnchor.constraint(equalTo: cup0.topAnchor, constant: 150),
      cube3.heightAnchor.constraint(equalToConstant: 60),
      cube3.widthAnchor.constraint(equalToConstant: 60),
      
      cube4.leftAnchor.constraint(equalTo: cube3.rightAnchor),
      cube4.topAnchor.constraint(equalTo: cup0.topAnchor, constant: 175),
      cube4.heightAnchor.constraint(equalToConstant: 60),
      cube4.widthAnchor.constraint(equalToConstant: 60),
      
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
