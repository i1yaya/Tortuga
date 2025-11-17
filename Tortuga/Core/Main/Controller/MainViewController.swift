import UIKit

class MainViewController: UIViewController {
  private var mainView: MainView!
  private let device = UIDevice()
  
  private var soundPosition: CGFloat = 0.0
  private var soundOff: Bool = false
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupBalance()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupController()
    setupView()
    setupTargets()
    setupDelegate()
    
    getData()
    getVolume()
    
    animateGameInfo(entrySize: 0.01, entryDuration: 0.01)
    animateHowToPlay(entrySize: 1.0, entryDuration: 0.01, entryPosition: 65)
  }
  
  private func getData() {
    if CGFloat(UserDefaults.standard.double(forKey: "sound")) >= 100 {
      soundPosition = CGFloat(UserDefaults.standard.double(forKey: "sound"))
    }
    
    if UserDefaults.standard.string(forKey: "name") != nil {
      MainData.shared.nickname = UserDefaults.standard.string(forKey: "name")!
      mainView.helloLabel.text = "Ahoy, \(MainData.shared.nickname)!"
    }
    
    if UserDefaults.standard.integer(forKey: "coin") != 0 {
      MainData.shared.coins = UserDefaults.standard.integer(forKey: "coin")
    } else {
      MainData.shared.coins = 1000
    }
  }
  
  private func getVolume() {
    SoundPlayer.shared.volumeEnable = UserDefaults.standard.bool(forKey: "soundEnable")
    soundOff = UserDefaults.standard.bool(forKey: "boolSound")
    
    if UserDefaults.standard.float(forKey: "volume") != 0.0 {
      MusicPlayer.shared.audioPlayer?.volume = UserDefaults.standard.float(forKey: "volume")
    } else if !soundOff {
      MusicPlayer.shared.audioPlayer?.volume = 0.65
    } else {
      MusicPlayer.shared.audioPlayer?.volume = 0.0
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  private func setupController() {
    navigationItem.backButtonTitle = ""
  }
  
  private func setupView() {
    mainView = MainView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    mainView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(mainView)
    
    let constraints = [
      mainView.leftAnchor.constraint(equalTo: view.leftAnchor),
      mainView.rightAnchor.constraint(equalTo: view.rightAnchor),
      mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      mainView.topAnchor.constraint(equalTo: view.topAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
  }
  
  private func setupTargets() {
    mainView.helpButton.addTarget(self, action: #selector(helpAction), for: .touchUpInside)
    mainView.backButton.addTarget(self, action: #selector(helpBackAction), for: .touchUpInside)
    mainView.settingButton.addTarget(self, action: #selector(settingAction), for: .touchUpInside)
    mainView.menuButton.addTarget(self, action: #selector(settingBackAction), for: .touchUpInside)
    mainView.gameInfoBackButton.addTarget(self, action: #selector(gameInfoBackAction), for: .touchUpInside)
    mainView.playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
    mainView.nickNameEdit.addTarget(self, action: #selector(setupNickName), for: .touchUpInside)
    mainView.noMoneyBackButton.addTarget(self, action: #selector(noMoneyBackAction), for: .touchUpInside)
    mainView.noMoneyButton.addTarget(self, action: #selector(noMoneyMenuAction), for: .touchUpInside)
    
    let gameButtons = [mainView.yatzyButton, mainView.battleButton, mainView.diceButton, mainView.wheelButton]
    
    for gameButton in gameButtons {
      gameButton.addTarget(self, action: #selector(gameInfoAction), for: .touchUpInside)
    }
    
    let playButtons = [mainView.lightButton, mainView.mediumButton, mainView.hardButton]
    
    for playButton in playButtons {
      playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
    }
  }
  
  private func setupDelegate() {
    mainView.nickName.delegate = self
  }
  
  @objc func setupNickName() {
    for _ in 0...1 {
      mainView.nickName.isEnabled.toggle()
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
      if self?.soundPosition != 0.0 && self?.soundPosition != nil {
        self?.mainView.soundMixer.layer.position.x = self!.soundPosition
      }
    }
  }
  
  @objc func helpAction() {
    mainView.helpScreen.isHidden.toggle()
    mainView.backButton.isHidden.toggle()
    
    editButtons(value: false)
    mainView.backButton.isEnabled = true
    
    animateHowToPlay(entrySize: 1.0, entryDuration: 1, entryPosition: -65)
  }
  
  @objc func helpBackAction() {
    editButtons(value: true)
    
    animateHowToPlay(entrySize: 1.0, entryDuration: 1, entryPosition: 65)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
      self?.mainView.helpScreen.isHidden.toggle()
      self?.mainView.backButton.isHidden.toggle()
    }
  }
  
  @objc func settingAction() {
    if soundPosition != 0.0 {
      mainView.soundMixer.layer.position.x = soundPosition
    }
    
    mainView.settingScreen.isHidden.toggle()
    mainView.menuButton.isHidden.toggle()
    mainView.settingLabel.isHidden.toggle()
    mainView.soundLabel.isHidden.toggle()
    mainView.soundLine.isHidden.toggle()
    mainView.soundMixer.isHidden.toggle()
    mainView.nickName.isHidden.toggle()
    mainView.nickNameEdit.isHidden.toggle()
    
    editButtons(value: false)
    mainView.menuButton.isEnabled = true
  }
  
  @objc func settingBackAction() {
    mainView.settingScreen.isHidden.toggle()
    mainView.menuButton.isHidden.toggle()
    mainView.settingLabel.isHidden.toggle()
    mainView.soundLabel.isHidden.toggle()
    mainView.soundLine.isHidden.toggle()
    mainView.soundMixer.isHidden.toggle()
    mainView.nickName.isHidden.toggle()
    mainView.nickNameEdit.isHidden.toggle()
    
    editButtons(value: true)
  }
  
  @objc func gameInfoAction(_ sender: UIButton) {
    mainView.playButton.tag = sender.tag
    
    switch sender.tag {
    case 0:
      mainView.yatzyMark.isHidden = false
    case 1:
      mainView.battleMark.isHidden = false
    case 2:
      mainView.diceMark.isHidden = false
    case 3:
      mainView.wheelMark.isHidden = false
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) { [weak self] in
        
        if MainData.shared.coins < 1000 {
          self?.mainView.hard0.isHidden = false
          self?.mainView.hard1.isHidden = false
        }
        if MainData.shared.coins < 500 {
          self?.mainView.medium0.isHidden = false
          self?.mainView.medium1.isHidden = false
        }
        if MainData.shared.coins < 250 {
          self?.mainView.light0.isHidden = false
          self?.mainView.light1.isHidden = false
        }
        
        self?.mainView.lightButton.isHidden = false
        self?.mainView.mediumButton.isHidden = false
        self?.mainView.hardButton.isHidden = false
      }
    default:
      print("Error: unowned tag")
    }
    
    mainView.gameInfo.image = UIImage(named: "Info\(sender.tag)")
    editButtons(value: false)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      self?.mainView.gameInfo.isHidden = false
      self?.mainView.gameInfoGround.isHidden = false
      
      self?.animateGameInfo(entrySize: 100, entryDuration: 0.75)
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
        self?.mainView.gameInfoBackButton.isHidden = false
        if sender.tag != 3 {
          self?.mainView.playButton.isHidden = false
        }
      }
    }
  }
  
  @objc func gameInfoBackAction() {
    mainView.yatzyMark.isHidden = true
    mainView.battleMark.isHidden = true
    mainView.diceMark.isHidden = true
    mainView.wheelMark.isHidden = true
    mainView.lightButton.isHidden = true
    mainView.mediumButton.isHidden = true
    mainView.hardButton.isHidden = true
    mainView.hard0.isHidden = true
    mainView.hard1.isHidden = true
    mainView.medium0.isHidden = true
    mainView.medium1.isHidden = true
    mainView.light0.isHidden = true
    mainView.light1.isHidden = true
    
    editButtons(value: true)
    
    mainView.gameInfoBackButton.isHidden = true
    mainView.playButton.isHidden = true
    
    animateGameInfo(entrySize: 0.01, entryDuration: 0.75)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
      self?.mainView.gameInfoGround.isHidden = true
      self?.mainView.gameInfo.isHidden = true
    }
  }
  
  @objc func playAction(_ sender: UIButton) {
    switch sender.tag {
    case 0:
      navigationController?.pushViewController(YatzyViewController(), animated: true)
      gameInfoBackAction()
    case 1:
      navigationController?.pushViewController(BattleViewController(), animated: true)
      gameInfoBackAction()
    case 2:
      navigationController?.pushViewController(DiceViewController(), animated: true)
      gameInfoBackAction()
    case 7:
      if MainData.shared.coins >= 250 {
        let viewController = WheelViewController()
        viewController.selected = 0
        navigationController?.pushViewController(viewController, animated: true)
        gameInfoBackAction()
      } else {
        mainView.noMoneyImage.image = UIImage(named: "NoMoneyImage0")
        mainView.noMoneyImage.isHidden = false
        mainView.noMoneyButton.isHidden = false
        mainView.noMoneyGround.isHidden = false
        mainView.noMoneyBackButton.isHidden = false
      }
    case 8:
      if MainData.shared.coins >= 500 {
        let viewController = WheelViewController()
        viewController.selected = 1
        navigationController?.pushViewController(viewController, animated: true)
        gameInfoBackAction()
      } else {
        mainView.noMoneyImage.image = UIImage(named: "NoMoneyImage1")
        mainView.noMoneyImage.isHidden = false
        mainView.noMoneyButton.isHidden = false
        mainView.noMoneyGround.isHidden = false
        mainView.noMoneyBackButton.isHidden = false
      }
    case 9:
      if MainData.shared.coins >= 1000 {
        let viewController = WheelViewController()
        viewController.selected = 2
        navigationController?.pushViewController(viewController, animated: true)
        gameInfoBackAction()
      } else {
        mainView.noMoneyImage.image = UIImage(named: "NoMoneyImage2")
        mainView.noMoneyImage.isHidden = false
        mainView.noMoneyButton.isHidden = false
        mainView.noMoneyGround.isHidden = false
        mainView.noMoneyBackButton.isHidden = false
      }
    default:
      print("Error: unowned tag")
    }
  }
  
  @objc func noMoneyBackAction() {
    mainView.noMoneyImage.isHidden = true
    mainView.noMoneyButton.isHidden = true
    mainView.noMoneyGround.isHidden = true
    mainView.noMoneyBackButton.isHidden = true
  }
  
  @objc func noMoneyMenuAction() {
    mainView.noMoneyImage.isHidden = true
    mainView.noMoneyButton.isHidden = true
    mainView.noMoneyGround.isHidden = true
    mainView.noMoneyBackButton.isHidden = true
    gameInfoBackAction()
  }
  
  private func editButtons(value: Bool) {
    let buttons = [mainView.backButton, mainView.battleButton, mainView.diceButton, mainView.helpButton, mainView.menuButton, mainView.settingButton, mainView.wheelButton, mainView.yatzyButton]
    
    for button in buttons {
      button.isEnabled = value
    }
  }
  
  private func animateGameInfo(entrySize: CGFloat, entryDuration: Double) {
    let originalTransform = mainView.gameInfo.transform
    let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.mainView.gameInfo.transform = scaledAndTranslatedTransform
    })
  }
  
  private func animateHowToPlay(entrySize: CGFloat, entryDuration: Double, entryPosition: CGFloat) {
    let originalTransform = mainView.helpScreen.transform
    let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: entryPosition, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.mainView.helpScreen.transform = scaledAndTranslatedTransform
    })
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
        mainView.coinLabel.text = "\(thousands) 00\(coins)"
      } else if coins < 100 {
        mainView.coinLabel.text = "\(thousands) 0\(coins)"
      } else {
        mainView.coinLabel.text = "\(thousands) \(coins)"
      }
    } else {
      mainView.coinLabel.text = "\(MainData.shared.coins)"
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let location = touch.location(in: self.view)
      if location.x >= mainView.soundLine.frame.minX && location.x <= mainView.soundLine.frame.maxX {
        soundPosition = location.x
        mainView.soundMixer.layer.position.x = soundPosition
      }
      
      if soundPosition <= mainView.soundLine.frame.minX + 10 {
        soundOff = true
        MusicPlayer.shared.audioPlayer?.volume = 0.0
        SoundPlayer.shared.volumeEnable = false
      } else if soundPosition <= mainView.soundLine.frame.midX {
        soundOff = false
        MusicPlayer.shared.audioPlayer?.volume = Float(soundPosition / 1000)
        SoundPlayer.shared.volumeEnable = true
      } else {
        soundOff = false
        MusicPlayer.shared.audioPlayer?.volume = Float((soundPosition / 700) * 1.5)
        SoundPlayer.shared.volumeEnable = true
      }
      print(Float((soundPosition / 700) * 1.5))
      UserDefaults.standard.set((MusicPlayer.shared.audioPlayer?.volume)!, forKey: "volume")
      UserDefaults.standard.set(soundOff, forKey: "boolSound")
    }
    let sound = Double(soundPosition)
    
    UserDefaults.standard.set(sound, forKey: "sound")
    UserDefaults.standard.set(SoundPlayer.shared.volumeEnable, forKey: "soundEnable")
  }
}

extension MainViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.text == "\(MainData.shared.nickname)" {
      textField.text = ""
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField.text == "" || textField.text == nil {
      textField.text = MainData.shared.nickname
    }
    
    if textField.text != nil {
      MainData.shared.nickname = textField.text!
      UserDefaults.standard.set(MainData.shared.nickname, forKey: "name")
      mainView.helloLabel.text = "Ahoy, \(MainData.shared.nickname)!"
      mainView.nickName.text = "\(MainData.shared.nickname)"
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
        if self?.soundPosition != 0.0 && self?.soundPosition != nil {
          self?.mainView.soundMixer.layer.position.x = self!.soundPosition
        }
      }
    }
  }
}
