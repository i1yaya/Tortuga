import UIKit

class YatzyView: UIView {
  private let device = UIDevice()
  
  public let background: UIImageView = {
    let image = UIImage(named: "YatzyBackground")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let ground: UIImageView = {
    let image = UIImage(named: "YatzyGround")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let list: UIImageView = {
    let image = UIImage(named: "YatzyList")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.register(YatzyCollectionViewCell.self, forCellWithReuseIdentifier: YatzyCollectionViewCell.id)
    collectionView.showsVerticalScrollIndicator = false
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  public let rollButton: UIButton = {
    let image = UIImage(named: "RollButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let pauseButton: UIButton = {
    let image = UIImage(named: "PauseButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let helpButton: UIButton = {
    let image = UIImage(named: "HelpButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let player0: UIImageView = {
    let image = UIImage(named: "YatzyUnder")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let player1: UIImageView = {
    let image = UIImage(named: "YatzyUnder")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let player2: UIImageView = {
    let image = UIImage(named: "YatzyUnder")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let player3: UIImageView = {
    let image = UIImage(named: "YatzyUnder")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let player4: UIImageView = {
    let image = UIImage(named: "YatzyUnder")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let enemy0: UIImageView = {
    let image = UIImage(named: "YatzyUnder")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let enemy1: UIImageView = {
    let image = UIImage(named: "YatzyUnder")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let enemy2: UIImageView = {
    let image = UIImage(named: "YatzyUnder")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let enemy3: UIImageView = {
    let image = UIImage(named: "YatzyUnder")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let enemy4: UIImageView = {
    let image = UIImage(named: "YatzyUnder")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let blurFrame: UIImageView = {
    let image = UIImage(named: "PauseBackground")
    let imageView = UIImageView(image: image)
    imageView.alpha = 0.75
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let blurLabel: UIImageView = {
    let image = UIImage(named: "MakeBetLabel")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let startButton: UIButton = {
    let image = UIImage(named: "StartButton")
    let imageView = UIButton()
    imageView.setBackgroundImage(image, for: .normal)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
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
  
  public let comboGround: UIImageView = {
    let image = UIImage(named: "Combinations0")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    return imageView
  }()
  
  public let rightButton: UIButton = {
    let image = UIImage(named: "RightButton")
    let imageView = UIButton()
    imageView.setBackgroundImage(image, for: .normal)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    return imageView
  }()
  
  public let backButton: UIButton = {
    let image = UIImage(named: "BackButton")
    let imageView = UIButton()
    imageView.setBackgroundImage(image, for: .normal)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    return imageView
  }()
  
  public let yatzyBackButton: UIButton = {
    let image = UIImage(named: "BackButton")
    let imageView = UIButton()
    imageView.setBackgroundImage(image, for: .normal)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
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
  
  public let scoreLeft: UIImageView = {
    let image = UIImage(named: "Cube3")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let scoreRight: UIImageView = {
    let image = UIImage(named: "Cube0")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let scoreCount: UILabel = {
    let label = UILabel()
    label.text = "2000"
    label.font = UIFont(name: "DEATH CROW DEMO", size: 32)
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.textAlignment = .center
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
    addSubview(list)
    addSubview(collectionView)
    addSubview(rollButton)
    addSubview(pauseButton)
    addSubview(helpButton)
    addSubview(player0)
    addSubview(player1)
    addSubview(player2)
    addSubview(player3)
    addSubview(player4)
    addSubview(enemy0)
    addSubview(enemy1)
    addSubview(enemy2)
    addSubview(enemy3)
    addSubview(enemy4)
    addSubview(cube0)
    addSubview(cube1)
    addSubview(cube2)
    addSubview(cube3)
    addSubview(cube4)
    addSubview(blurFrame)
    addSubview(blurLabel)
    addSubview(startButton)
    addSubview(balanceGround)
    addSubview(betGround)
    addSubview(balanceLabel)
    addSubview(betCount)
    addSubview(comboGround)
    addSubview(rightButton)
    addSubview(backButton)
    addSubview(result)
    addSubview(menuButton)
    addSubview(restartButton)
    addSubview(winFrame)
    addSubview(winCount)
    addSubview(scoreLeft)
    addSubview(scoreRight)
    addSubview(scoreCount)
    addSubview(yatzyBackButton)
    
    if device.model == .iPhone8 {
      let constraints = [
        list.rightAnchor.constraint(equalTo: rightAnchor, constant: 25),
        list.centerYAnchor.constraint(equalTo: centerYAnchor),
        
        rollButton.leftAnchor.constraint(equalTo: leftAnchor, constant: -50),
        rollButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ground.centerYAnchor.constraint(equalTo: centerYAnchor),
        ground.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        
        pauseButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
        pauseButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        helpButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
        helpButton.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 12),
        
        player4.rightAnchor.constraint(equalTo: list.leftAnchor, constant: 40),
        player4.bottomAnchor.constraint(equalTo: ground.bottomAnchor, constant: -50),
        
        enemy4.rightAnchor.constraint(equalTo: list.leftAnchor, constant: 40),
        enemy4.topAnchor.constraint(equalTo: ground.topAnchor, constant: 50),
        
        comboGround.centerYAnchor.constraint(equalTo: centerYAnchor),
        comboGround.centerXAnchor.constraint(equalTo: centerXAnchor),
        comboGround.widthAnchor.constraint(equalToConstant: 638 * 0.85),
        comboGround.heightAnchor.constraint(equalToConstant: 364 * 0.85),
        
        backButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
        backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        rightButton.leftAnchor.constraint(equalTo: comboGround.rightAnchor),
        
        yatzyBackButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
        yatzyBackButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      ]
      NSLayoutConstraint.activate(constraints)
    } else if device.model == .iPhone8Plus {
      let constraints = [
        list.rightAnchor.constraint(equalTo: rightAnchor, constant: 25),
        list.centerYAnchor.constraint(equalTo: centerYAnchor),
        
        rollButton.leftAnchor.constraint(equalTo: leftAnchor, constant: -50),
        rollButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ground.centerYAnchor.constraint(equalTo: centerYAnchor),
        ground.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        
        pauseButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
        pauseButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        helpButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
        helpButton.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 12),
        
        player4.rightAnchor.constraint(equalTo: list.leftAnchor, constant: 0),
        player4.bottomAnchor.constraint(equalTo: ground.bottomAnchor, constant: -50),
        
        enemy4.rightAnchor.constraint(equalTo: list.leftAnchor, constant: 0),
        enemy4.topAnchor.constraint(equalTo: ground.topAnchor, constant: 50),
        
        comboGround.centerYAnchor.constraint(equalTo: centerYAnchor),
        comboGround.centerXAnchor.constraint(equalTo: centerXAnchor),
        comboGround.widthAnchor.constraint(equalToConstant: 638 * 0.85),
        comboGround.heightAnchor.constraint(equalToConstant: 364 * 0.85),
        
        backButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
        backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        rightButton.leftAnchor.constraint(equalTo: comboGround.rightAnchor),
        
        yatzyBackButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
        yatzyBackButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      ]
      NSLayoutConstraint.activate(constraints)
    } else if device.model == .iPhone11 {
      let constraints = [
        list.rightAnchor.constraint(equalTo: rightAnchor, constant: -50),
        list.centerYAnchor.constraint(equalTo: centerYAnchor),
        
        ground.centerYAnchor.constraint(equalTo: centerYAnchor),
        ground.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 35),
        
        rollButton.leftAnchor.constraint(equalTo: leftAnchor),
        rollButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        pauseButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        pauseButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        helpButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        helpButton.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 12),
        
        player4.rightAnchor.constraint(equalTo: list.leftAnchor, constant: -10),
        player4.bottomAnchor.constraint(equalTo: ground.bottomAnchor, constant: -50),
        
        enemy4.rightAnchor.constraint(equalTo: list.leftAnchor, constant: -10),
        enemy4.topAnchor.constraint(equalTo: ground.topAnchor, constant: 50),
        
        comboGround.centerYAnchor.constraint(equalTo: centerYAnchor),
        comboGround.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        backButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        rightButton.leftAnchor.constraint(equalTo: comboGround.rightAnchor),
        
        yatzyBackButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        yatzyBackButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      ]
      NSLayoutConstraint.activate(constraints)
    } else if device.model == .iPhone14ProMax || device.model == .iPhone12Pro {
      let constraints = [
        list.rightAnchor.constraint(equalTo: rightAnchor, constant: -60),
        list.centerYAnchor.constraint(equalTo: centerYAnchor),
        
        ground.centerYAnchor.constraint(equalTo: centerYAnchor),
        ground.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 75),
        
        rollButton.leftAnchor.constraint(equalTo: leftAnchor),
        rollButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        pauseButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        pauseButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        helpButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        helpButton.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 12),
        
        player4.rightAnchor.constraint(equalTo: list.leftAnchor, constant: -10),
        player4.bottomAnchor.constraint(equalTo: ground.bottomAnchor, constant: -50),
        
        enemy4.rightAnchor.constraint(equalTo: list.leftAnchor, constant: -10),
        enemy4.topAnchor.constraint(equalTo: ground.topAnchor, constant: 50),
        
        comboGround.centerYAnchor.constraint(equalTo: centerYAnchor),
        comboGround.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        backButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        rightButton.leftAnchor.constraint(equalTo: comboGround.rightAnchor),
        
        yatzyBackButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        yatzyBackButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      ]
      NSLayoutConstraint.activate(constraints)
    } else {
      let constraints = [
        list.rightAnchor.constraint(equalTo: rightAnchor, constant: -25),
        list.centerYAnchor.constraint(equalTo: centerYAnchor),
        
        ground.centerYAnchor.constraint(equalTo: centerYAnchor),
        ground.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        
        rollButton.leftAnchor.constraint(equalTo: leftAnchor),
        rollButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        pauseButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        pauseButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        helpButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        helpButton.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 12),
        
        player4.rightAnchor.constraint(equalTo: list.leftAnchor, constant: -10),
        player4.bottomAnchor.constraint(equalTo: ground.bottomAnchor, constant: -50),
        
        enemy4.rightAnchor.constraint(equalTo: list.leftAnchor, constant: -10),
        enemy4.topAnchor.constraint(equalTo: ground.topAnchor, constant: 50),
        
        comboGround.centerYAnchor.constraint(equalTo: centerYAnchor),
        comboGround.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        backButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        
        rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        rightButton.leftAnchor.constraint(equalTo: comboGround.rightAnchor),
        
        yatzyBackButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        yatzyBackButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      ]
      NSLayoutConstraint.activate(constraints)
    }
    
    let constraints = [
      background.rightAnchor.constraint(equalTo: rightAnchor),
      background.leftAnchor.constraint(equalTo: leftAnchor),
      background.topAnchor.constraint(equalTo: topAnchor),
      background.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      collectionView.rightAnchor.constraint(equalTo: list.rightAnchor),
      collectionView.leftAnchor.constraint(equalTo: list.leftAnchor),
      collectionView.topAnchor.constraint(equalTo: list.topAnchor, constant: -6.5),
      collectionView.bottomAnchor.constraint(equalTo: list.bottomAnchor),
      
      player3.rightAnchor.constraint(equalTo: player4.leftAnchor, constant: -10),
      player3.bottomAnchor.constraint(equalTo: ground.bottomAnchor, constant: -50),
      
      player2.rightAnchor.constraint(equalTo: player3.leftAnchor, constant: -10),
      player2.bottomAnchor.constraint(equalTo: ground.bottomAnchor, constant: -50),
      
      player1.rightAnchor.constraint(equalTo: player2.leftAnchor, constant: -10),
      player1.bottomAnchor.constraint(equalTo: ground.bottomAnchor, constant: -50),
      
      player0.rightAnchor.constraint(equalTo: player1.leftAnchor, constant: -10),
      player0.bottomAnchor.constraint(equalTo: ground.bottomAnchor, constant: -50),
      
      enemy3.rightAnchor.constraint(equalTo: enemy4.leftAnchor, constant: -10),
      enemy3.topAnchor.constraint(equalTo: ground.topAnchor, constant: 50),
      
      enemy2.rightAnchor.constraint(equalTo: enemy3.leftAnchor, constant: -10),
      enemy2.topAnchor.constraint(equalTo: ground.topAnchor, constant: 50),
      
      enemy1.rightAnchor.constraint(equalTo: enemy2.leftAnchor, constant: -10),
      enemy1.topAnchor.constraint(equalTo: ground.topAnchor, constant: 50),
      
      enemy0.rightAnchor.constraint(equalTo: enemy1.leftAnchor, constant: -10),
      enemy0.topAnchor.constraint(equalTo: ground.topAnchor, constant: 50),
      
      blurFrame.rightAnchor.constraint(equalTo: rightAnchor),
      blurFrame.leftAnchor.constraint(equalTo: leftAnchor),
      blurFrame.topAnchor.constraint(equalTo: topAnchor),
      blurFrame.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      startButton.topAnchor.constraint(equalTo: betGround.bottomAnchor),
      
      blurLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      blurLabel.bottomAnchor.constraint(equalTo: betGround.topAnchor),
      
      balanceGround.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
      balanceGround.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      
      balanceLabel.rightAnchor.constraint(equalTo: balanceGround.rightAnchor, constant: -25),
      balanceLabel.centerYAnchor.constraint(equalTo: balanceGround.centerYAnchor),
      
      betGround.centerYAnchor.constraint(equalTo: centerYAnchor),
      betGround.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      betCount.leftAnchor.constraint(equalTo: betGround.leftAnchor, constant: 35),
      betCount.centerYAnchor.constraint(equalTo: betGround.centerYAnchor),
      betCount.heightAnchor.constraint(equalToConstant: 50),
      betCount.widthAnchor.constraint(equalToConstant: 75),
      
      cube2.centerYAnchor.constraint(equalTo: centerYAnchor),
      cube2.rightAnchor.constraint(equalTo: centerXAnchor, constant: -50),
      cube2.heightAnchor.constraint(equalToConstant: 50),
      cube2.widthAnchor.constraint(equalToConstant: 50),
      
      cube3.centerYAnchor.constraint(equalTo: cube2.bottomAnchor),
      cube3.leftAnchor.constraint(equalTo: cube2.rightAnchor, constant: 10),
      cube3.heightAnchor.constraint(equalToConstant: 50),
      cube3.widthAnchor.constraint(equalToConstant: 50),
      
      cube4.centerYAnchor.constraint(equalTo: cube2.centerYAnchor),
      cube4.leftAnchor.constraint(equalTo: cube3.rightAnchor, constant: 10),
      cube4.heightAnchor.constraint(equalToConstant: 50),
      cube4.widthAnchor.constraint(equalToConstant: 50),
      
      cube1.centerYAnchor.constraint(equalTo: cube2.topAnchor),
      cube1.rightAnchor.constraint(equalTo: cube2.leftAnchor, constant: -10),
      cube1.heightAnchor.constraint(equalToConstant: 50),
      cube1.widthAnchor.constraint(equalToConstant: 50),
      
      cube0.centerYAnchor.constraint(equalTo: cube2.centerYAnchor),
      cube0.rightAnchor.constraint(equalTo: cube1.leftAnchor, constant: -10),
      cube0.heightAnchor.constraint(equalToConstant: 50),
      cube0.widthAnchor.constraint(equalToConstant: 50),
      
      result.rightAnchor.constraint(equalTo: rightAnchor),
      result.leftAnchor.constraint(equalTo: leftAnchor),
      result.topAnchor.constraint(equalTo: topAnchor),
      result.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      menuButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 20),
      menuButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      restartButton.bottomAnchor.constraint(equalTo: menuButton.topAnchor, constant: 35),
      restartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      winFrame.bottomAnchor.constraint(equalTo: menuButton.topAnchor, constant: 30),
      winFrame.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      winCount.centerYAnchor.constraint(equalTo: winFrame.centerYAnchor),
      winCount.rightAnchor.constraint(equalTo: winFrame.centerXAnchor, constant: 25),
      
      scoreCount.centerXAnchor.constraint(equalTo: centerXAnchor),
      scoreCount.bottomAnchor.constraint(equalTo: restartButton.topAnchor, constant: 15),
      
      scoreLeft.centerYAnchor.constraint(equalTo: scoreCount.centerYAnchor),
      scoreLeft.rightAnchor.constraint(equalTo: scoreCount.leftAnchor, constant: -15),
      scoreLeft.heightAnchor.constraint(equalToConstant: 35),
      scoreLeft.widthAnchor.constraint(equalToConstant: 35),
      
      scoreRight.centerYAnchor.constraint(equalTo: scoreCount.centerYAnchor),
      scoreRight.leftAnchor.constraint(equalTo: scoreCount.rightAnchor, constant: 15),
      scoreRight.heightAnchor.constraint(equalToConstant: 35),
      scoreRight.widthAnchor.constraint(equalToConstant: 35),
    ]
    NSLayoutConstraint.activate(constraints)
  }
}
