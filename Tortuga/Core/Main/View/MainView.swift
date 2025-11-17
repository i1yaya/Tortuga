import UIKit

class MainView: UIView {
  private let device = UIDevice()
  
  public let background: UIImageView = {
    let image = UIImage(named: "MainBackground")
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let logo: UIImageView = {
    let image = UIImage(named: "MainLogo")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let list: UIImageView = {
    let image = UIImage(named: "MainList")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let helpButton: UIButton = {
    let image = UIImage(named: "MainHelp")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let settingButton: UIButton = {
    let image = UIImage(named: "MainSetting")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let helloLabel: UILabel = {
    let label = UILabel()
    label.text = "Ahoy, \(MainData.shared.nickname)!"
    label.font = UIFont(name: "Papyrus", size: 16)
    label.textColor = #colorLiteral(red: 0.4468473792, green: 0.3058497608, blue: 0.1608744562, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  public let scoreLabel: UILabel = {
    let label = UILabel()
    label.text = "Your score:"
    label.font = UIFont(name: "Papyrus", size: 12)
    label.textColor = #colorLiteral(red: 0.4468473792, green: 0.3058497608, blue: 0.1608744562, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  public let coinLabel: UILabel = {
    let label = UILabel()
    label.text = "27 500"
    label.font = UIFont(name: "Papyrus", size: 16)
    label.textColor = #colorLiteral(red: 0.4468473792, green: 0.3058497608, blue: 0.1608744562, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  public let coinImage: UIImageView = {
    let image = UIImage(named: "MainCoin")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let wheelButton: UIButton = {
    let image = UIImage(named: "MainWheel")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.tag = 3
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let wheelMark: UIImageView = {
    let image = UIImage(named: "MainMark")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let diceButton: UIButton = {
    let image = UIImage(named: "MainDice")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.tag = 2
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let diceMark: UIImageView = {
    let image = UIImage(named: "MainMark")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let battleButton: UIButton = {
    let image = UIImage(named: "MainBattle")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.tag = 1
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let battleMark: UIImageView = {
    let image = UIImage(named: "MainMark")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let yatzyButton: UIButton = {
    let image = UIImage(named: "MainYatzy")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.tag = 0
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let yatzyMark: UIImageView = {
    let image = UIImage(named: "MainMark")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let roadImage: UIImageView = {
    let image = UIImage(named: "MainRoad")
    let imageView = UIImageView(image: image)
    imageView.alpha = 0.1
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let helpScreen: UIImageView = {
    let image = UIImage(named: "MainHelpScreen")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let backButton: UIButton = {
    let image = UIImage(named: "BackButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let settingScreen: UIImageView = {
    let image = UIImage(named: "MainSettingScreen")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.alpha = 0.75
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let menuButton: UIButton = {
    let image = UIImage(named: "MainMenuButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let settingLabel: UIImageView = {
    let image = UIImage(named: "MainSettingLabel")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let soundLabel: UIImageView = {
    let image = UIImage(named: "MainSoundLabel")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let soundLine: UIImageView = {
    let image = UIImage(named: "MainSoundLine")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let soundMixer: UIImageView = {
    let image = UIImage(named: "MainSoundMixer")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let nickName: UITextField = {
    let textField = UITextField()
    textField.text = "\(MainData.shared.nickname)"
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .clear
    textField.borderStyle = .none
    textField.font = UIFont(name: "Papyrus", size: 20)
    textField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    textField.textAlignment = .left
    textField.isHidden = true
    textField.tintColor = .clear
    textField.layer.cornerRadius = 15
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  public let nickNameEdit: UIButton = {
    let image = UIImage(named: "MainNameEdit")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let gameInfoGround: UIImageView = {
    let image = UIImage(named: "GameInfoGround")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.alpha = 0.75
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let gameInfo: UIImageView = {
    let image = UIImage(named: "YatzyInfo")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let playButton: UIButton = {
    let image = UIImage(named: "PlayButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let gameInfoBackButton: UIButton = {
    let image = UIImage(named: "BackButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let lightButton: UIButton = {
    let image = UIImage(named: "LightButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.tag = 7
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let light0: UIImageView = {
    let image = UIImage(named: "Lock")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let light1: UIImageView = {
    let image = UIImage(named: "Lock")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let mediumButton: UIButton = {
    let image = UIImage(named: "MediumButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.tag = 8
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let medium0: UIImageView = {
    let image = UIImage(named: "Lock")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let medium1: UIImageView = {
    let image = UIImage(named: "Lock")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let hardButton: UIButton = {
    let image = UIImage(named: "HardButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.tag = 9
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let hard0: UIImageView = {
    let image = UIImage(named: "Lock")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let hard1: UIImageView = {
    let image = UIImage(named: "Lock")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let noMoneyGround: UIImageView = {
    let image = UIImage(named: "PauseBackground")
    let imageView = UIImageView(image: image)
    imageView.alpha = 0.9
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let noMoneyButton: UIButton = {
    let image = UIImage(named: "MenuButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let noMoneyBackButton: UIButton = {
    let image = UIImage(named: "BackButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let noMoneyImage: UIImageView = {
    let image = UIImage(named: "NoMoneyImage0")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
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
    addSubview(logo)
    addSubview(list)
    addSubview(helpButton)
    addSubview(settingButton)
    addSubview(helloLabel)
    addSubview(scoreLabel)
    addSubview(scoreLabel)
    addSubview(coinLabel)
    addSubview(coinImage)
    addSubview(wheelButton)
    addSubview(yatzyButton)
    addSubview(battleButton)
    addSubview(diceButton)
    addSubview(wheelMark)
    addSubview(yatzyMark)
    addSubview(battleMark)
    addSubview(diceMark)
    addSubview(roadImage)
    addSubview(helpScreen)
    addSubview(backButton)
    addSubview(settingScreen)
    addSubview(menuButton)
    addSubview(settingLabel)
    addSubview(soundLabel)
    addSubview(soundLine)
    addSubview(soundMixer)
    addSubview(nickName)
    addSubview(nickNameEdit)
    addSubview(gameInfoGround)
    addSubview(gameInfo)
    addSubview(playButton)
    addSubview(gameInfoBackButton)
    addSubview(lightButton)
    addSubview(mediumButton)
    addSubview(hardButton)
    addSubview(light0)
    addSubview(light1)
    addSubview(medium0)
    addSubview(medium1)
    addSubview(hard0)
    addSubview(hard1)
    addSubview(noMoneyGround)
    addSubview(noMoneyButton)
    addSubview(noMoneyBackButton)
    addSubview(noMoneyImage)
    
    if device.model == .iPhone8 {
      let constraints = [
        helpButton.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
        helpButton.topAnchor.constraint(equalTo: list.bottomAnchor, constant: -10),
        
        diceButton.topAnchor.constraint(equalTo: topAnchor, constant: -15),
        diceButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        yatzyButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 5),
        yatzyButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        noMoneyBackButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 15),
        noMoneyBackButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      ]
      NSLayoutConstraint.activate(constraints)
    } else if device.model == .iPhoneX {
      let constraints = [
        helpButton.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
        helpButton.topAnchor.constraint(equalTo: list.bottomAnchor, constant: -10),
        
        diceButton.topAnchor.constraint(equalTo: topAnchor, constant: -15),
        diceButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        yatzyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        yatzyButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        noMoneyBackButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        noMoneyBackButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      ]
      NSLayoutConstraint.activate(constraints)
    } else {
      let constraints = [
        helpButton.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
        helpButton.topAnchor.constraint(equalTo: list.bottomAnchor),
        
        diceButton.topAnchor.constraint(equalTo: topAnchor),
        diceButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        yatzyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        yatzyButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        noMoneyBackButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
        noMoneyBackButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      ]
      NSLayoutConstraint.activate(constraints)
    }
    
    let constraints = [
      background.rightAnchor.constraint(equalTo: rightAnchor),
      background.leftAnchor.constraint(equalTo: leftAnchor),
      background.topAnchor.constraint(equalTo: topAnchor),
      background.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      logo.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
      logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      
      list.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
      list.topAnchor.constraint(equalTo: logo.bottomAnchor),
      
      settingButton.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
      settingButton.centerYAnchor.constraint(equalTo: helpButton.bottomAnchor),
      
      helloLabel.centerXAnchor.constraint(equalTo: list.centerXAnchor),
      helloLabel.topAnchor.constraint(equalTo: list.topAnchor, constant: 35),
      
      scoreLabel.centerXAnchor.constraint(equalTo: list.centerXAnchor, constant: -40),
      scoreLabel.topAnchor.constraint(equalTo: list.centerYAnchor),
      
      coinLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
      coinLabel.leftAnchor.constraint(equalTo: scoreLabel.rightAnchor, constant: 5),
      
      coinImage.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
      coinImage.leftAnchor.constraint(equalTo: coinLabel.rightAnchor),
      
      wheelButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
      wheelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      battleButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
      battleButton.centerYAnchor.constraint(equalTo: diceButton.centerYAnchor),
      
      roadImage.centerXAnchor.constraint(equalTo: centerXAnchor),
      roadImage.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      helpScreen.rightAnchor.constraint(equalTo: rightAnchor),
      helpScreen.leftAnchor.constraint(equalTo: leftAnchor),
      helpScreen.topAnchor.constraint(equalTo: topAnchor),
      helpScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      backButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
      backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      
      settingScreen.rightAnchor.constraint(equalTo: rightAnchor),
      settingScreen.leftAnchor.constraint(equalTo: leftAnchor),
      settingScreen.topAnchor.constraint(equalTo: topAnchor),
      settingScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      menuButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      menuButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      settingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      settingLabel.topAnchor.constraint(equalTo: topAnchor),
      
      soundLabel.bottomAnchor.constraint(equalTo: menuButton.topAnchor, constant: -25),
      soundLabel.rightAnchor.constraint(equalTo: centerXAnchor, constant: -50),
      
      soundLine.centerYAnchor.constraint(equalTo: soundLabel.centerYAnchor),
      soundLine.leftAnchor.constraint(equalTo: soundLabel.rightAnchor, constant: 20),
      
      soundMixer.centerYAnchor.constraint(equalTo: soundLine.centerYAnchor),
      soundMixer.centerXAnchor.constraint(equalTo: soundLine.centerXAnchor),
      
      nickName.bottomAnchor.constraint(equalTo: soundLabel.topAnchor, constant: -25),
      nickName.leftAnchor.constraint(equalTo: soundLabel.leftAnchor),
      nickName.widthAnchor.constraint(equalToConstant: 225),
      
      nickNameEdit.centerYAnchor.constraint(equalTo: nickName.centerYAnchor),
      nickNameEdit.rightAnchor.constraint(equalTo: soundLine.rightAnchor),
      
      gameInfoGround.rightAnchor.constraint(equalTo: rightAnchor),
      gameInfoGround.leftAnchor.constraint(equalTo: leftAnchor),
      gameInfoGround.topAnchor.constraint(equalTo: topAnchor),
      gameInfoGround.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      gameInfo.topAnchor.constraint(equalTo: topAnchor),
      gameInfo.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      playButton.bottomAnchor.constraint(equalTo: gameInfo.bottomAnchor),
      playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      gameInfoBackButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      gameInfoBackButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
      
      wheelMark.centerYAnchor.constraint(equalTo: wheelButton.centerYAnchor),
      wheelMark.centerXAnchor.constraint(equalTo: wheelButton.centerXAnchor),
      
      yatzyMark.centerYAnchor.constraint(equalTo: yatzyButton.centerYAnchor),
      yatzyMark.centerXAnchor.constraint(equalTo: yatzyButton.centerXAnchor),
      
      battleMark.centerYAnchor.constraint(equalTo: battleButton.centerYAnchor),
      battleMark.centerXAnchor.constraint(equalTo: battleButton.centerXAnchor),
      
      diceMark.centerYAnchor.constraint(equalTo: diceButton.centerYAnchor),
      diceMark.centerXAnchor.constraint(equalTo: diceButton.centerXAnchor),
      
      mediumButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      mediumButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      medium0.centerYAnchor.constraint(equalTo: mediumButton.centerYAnchor),
      medium0.leftAnchor.constraint(equalTo: mediumButton.leftAnchor, constant: 10),
      
      medium1.centerYAnchor.constraint(equalTo: mediumButton.centerYAnchor),
      medium1.rightAnchor.constraint(equalTo: mediumButton.rightAnchor, constant: -10),
      
      lightButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      lightButton.bottomAnchor.constraint(equalTo: mediumButton.topAnchor, constant: -5),
      
      light0.centerYAnchor.constraint(equalTo: lightButton.centerYAnchor),
      light0.leftAnchor.constraint(equalTo: lightButton.leftAnchor, constant: 10),
      
      light1.centerYAnchor.constraint(equalTo: lightButton.centerYAnchor),
      light1.rightAnchor.constraint(equalTo: lightButton.rightAnchor, constant: -10),
      
      hardButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      hardButton.topAnchor.constraint(equalTo: mediumButton.bottomAnchor, constant: 5),
      
      hard0.centerYAnchor.constraint(equalTo: hardButton.centerYAnchor),
      hard0.leftAnchor.constraint(equalTo: hardButton.leftAnchor, constant: 10),
      
      hard1.centerYAnchor.constraint(equalTo: hardButton.centerYAnchor),
      hard1.rightAnchor.constraint(equalTo: hardButton.rightAnchor, constant: -10),
      
      noMoneyGround.rightAnchor.constraint(equalTo: rightAnchor),
      noMoneyGround.leftAnchor.constraint(equalTo: leftAnchor),
      noMoneyGround.topAnchor.constraint(equalTo: topAnchor),
      noMoneyGround.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      noMoneyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      noMoneyButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      noMoneyImage.centerYAnchor.constraint(equalTo: centerYAnchor),
      noMoneyImage.centerXAnchor.constraint(equalTo: centerXAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
  }
}
