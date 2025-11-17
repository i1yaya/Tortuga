import UIKit

class YatzyViewController: UIViewController {
  private var yatzyView: YatzyView!
  private var pauseView: PauseView!
  
  private var comboNames: [String] = ["Ones", "Twos", "Threes", "Fours", "Fives", "Sixes", "Sum", "Bonus", "Three of a kind", "Four of a kind", "Full house", "Small straight", "Large straight", "Chance", "Yatzy", "Total score"]
  
  private var selectedCombo: Int = 0
  private var playerSelected: Int = -1
  private var enemySelected: Int = -1
  
  private var playerScores: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  private var enemyScores: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  
  private var playerTakeScores: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
  private var enemyTakeScores: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
  
  private var playerScore: Int = 0
  private var enemyScore: Int = 0
  
  private var rollCubes: [Int] = [0, 0, 0, 0, 0]
  private var takeCubes: [Int] = [0, 0, 0, 0, 0]
  
  private var turn: TurnType = .player
  private var turnNumber: Int = 0
  
  private var rollCount: Int = 0
  private var onBoard: Bool = false
  
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
    
    setupBalance()
    setupStartBet()
    
    editButtons(value: false)
    
    animateHelp(entrySize: 0.01, entryDuration: 0.01)
    animatePlayerRoll(entrySize: 5, entryDuration: 0.01, entryPosition: 100)
    animateResult(entrySize: 0.1, entryDuration: 0.01)
  }
  
  private func setupController() {
    navigationItem.hidesBackButton = true
  }
  
  private func setupView() {
    yatzyView = YatzyView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    yatzyView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(yatzyView)
    
    let constraints = [
      yatzyView.leftAnchor.constraint(equalTo: view.leftAnchor),
      yatzyView.rightAnchor.constraint(equalTo: view.rightAnchor),
      yatzyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      yatzyView.topAnchor.constraint(equalTo: view.topAnchor)
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
    yatzyView.startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
    yatzyView.pauseButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
    pauseView.resumeButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
    pauseView.replayButton.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
    pauseView.menuButton.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
    yatzyView.helpButton.addTarget(self, action: #selector(helpAction), for: .touchUpInside)
    yatzyView.backButton.addTarget(self, action: #selector(helpBackAction), for: .touchUpInside)
    yatzyView.rightButton.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
    yatzyView.rollButton.addTarget(self, action: #selector(rollAction), for: .touchUpInside)
    yatzyView.menuButton.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
    yatzyView.restartButton.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
    yatzyView.yatzyBackButton.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
    
    let cubes = [yatzyView.cube0, yatzyView.cube1, yatzyView.cube2, yatzyView.cube3, yatzyView.cube4]
    
    for cube in cubes {
      cube.addTarget(self, action: #selector(takeCube), for: .touchUpInside)
    }
  }
  
  @objc func takeCube(_ sender: UIButton) {
    if turn == .player {
      if takeCubes[sender.tag] == 0 {
        takeCubes[sender.tag] = rollCubes[sender.tag]
        switch sender.tag {
        case 0:
          animateTakeCube(cube: sender, entryPositionX: 0, entryPositionY: 115)
        case 1:
          animateTakeCube(cube: sender, entryPositionX: 10, entryPositionY: 135)
        case 2:
          animateTakeCube(cube: sender, entryPositionX: 20, entryPositionY: 120)
        case 3:
          animateTakeCube(cube: sender, entryPositionX: 25, entryPositionY: 100)
        case 4:
          animateTakeCube(cube: sender, entryPositionX: 30, entryPositionY: 115)
        default:
          animateTakeCube(cube: sender, entryPositionX: 0, entryPositionY: 0)
        }
      } else {
        takeCubes[sender.tag] = 0
        switch sender.tag {
        case 0:
          animateTakeCube(cube: sender, entryPositionX: 0, entryPositionY: -115)
        case 1:
          animateTakeCube(cube: sender, entryPositionX: -10, entryPositionY: -135)
        case 2:
          animateTakeCube(cube: sender, entryPositionX: -20, entryPositionY: -120)
        case 3:
          animateTakeCube(cube: sender, entryPositionX: -25, entryPositionY: -100)
        case 4:
          animateTakeCube(cube: sender, entryPositionX: -30, entryPositionY: -115)
        default:
          animateTakeCube(cube: sender, entryPositionX: 0, entryPositionY: 0)
        }
      }
    }
  }
  
  private func enemyTakeCube(entryTag: Int) {
    let cubes = [yatzyView.cube0, yatzyView.cube1, yatzyView.cube2, yatzyView.cube3, yatzyView.cube4]
    var sender: UIButton = cubes[0]
    
    for cube in cubes {
      if cube.tag == entryTag {
        sender = cube
      }
    }
    
    if takeCubes[sender.tag] == 0 {
      takeCubes[sender.tag] = rollCubes[sender.tag]
      switch sender.tag {
      case 0:
        animateTakeCube(cube: sender, entryPositionX: 0, entryPositionY: -115)
      case 1:
        animateTakeCube(cube: sender, entryPositionX: 10, entryPositionY: -100)
      case 2:
        animateTakeCube(cube: sender, entryPositionX: 20, entryPositionY: -120)
      case 3:
        animateTakeCube(cube: sender, entryPositionX: 25, entryPositionY: -135)
      case 4:
        animateTakeCube(cube: sender, entryPositionX: 30, entryPositionY: -115)
      default:
        animateTakeCube(cube: sender, entryPositionX: 0, entryPositionY: 0)
      }
    } else {
      takeCubes[sender.tag] = 0
      switch sender.tag {
      case 0:
        animateTakeCube(cube: sender, entryPositionX: 0, entryPositionY: 115)
      case 1:
        animateTakeCube(cube: sender, entryPositionX: -10, entryPositionY: 100)
      case 2:
        animateTakeCube(cube: sender, entryPositionX: -20, entryPositionY: 120)
      case 3:
        animateTakeCube(cube: sender, entryPositionX: -25, entryPositionY: 135)
      case 4:
        animateTakeCube(cube: sender, entryPositionX: -30, entryPositionY: 115)
      default:
        animateTakeCube(cube: sender, entryPositionX: 0, entryPositionY: 0)
      }
    }
  }
  
  @objc func pauseAction() {
    pauseView.isHidden.toggle()
  }
  
  @objc func menuAction() {
    navigationController?.popViewController(animated: true)
    
    rollCubes = [0, 0, 0, 0, 0]
    takeCubes = [0, 0, 0, 0, 0]
    rollCount = 0
  }
  
  @objc func restartAction() {
    let cubes = [yatzyView.cube0, yatzyView.cube1, yatzyView.cube2, yatzyView.cube3, yatzyView.cube4]
    
    for cube in cubes {
      cube.removeFromSuperview()
      cube.isHidden = false
    }
    
    rollCubes = [0, 0, 0, 0, 0]
    takeCubes = [0, 0, 0, 0, 0]
    rollCount = 0
    
    viewDidLoad()
    
    rollCubes = [0, 0, 0, 0, 0]
    takeCubes = [0, 0, 0, 0, 0]
    rollCount = 0
    
    for i in 0...comboNames.count - 1 {
      playerScores[i] = 0
      enemyScores[i] = 0
      playerTakeScores[i] = false
      enemyTakeScores[i] = false
    }
    
    turnNumber = 0
    turn = .player
    
    selectedCombo = 0
    playerSelected = -1
    enemySelected = -1
    
    playerScore = 0
    enemyScore = 0
  }
  
  @objc func enemyRollAction() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      SoundPlayer.shared.cubeSound()
    }
    rollCount += 1
    
    if rollCount <= 5 {
      if onBoard == false {
        animateEnemyRoll(entrySize: 0.2, entryDuration: 1.5, entryPosition: 500)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
          self?.checkEnemyCombo()
        }
        onBoard = true
      } else {
        for index in 0...enemyScores.count - 2 {
          if enemyTakeScores[index] != true {
            enemyScores[index] = 0
          }
        }
        
        animateEnemyRoll(entrySize: 5, entryDuration: 1.5, entryPosition: -100)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
          self?.enemyRollAction()
        }
        onBoard = false
      }
      
      if rollCount == 5 {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
          self?.yatzyView.collectionView.reloadData()
          self?.yatzyView.rollButton.isEnabled = true
        }
      }
    }
  }
  
  @objc func rollAction() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      SoundPlayer.shared.cubeSound()
    }
    rollCount += 1
    
    if rollCount <= 5 {
      if onBoard == false {
        yatzyView.rollButton.isEnabled = false
        
        let cubes = [yatzyView.cube0, yatzyView.cube1, yatzyView.cube2, yatzyView.cube3, yatzyView.cube4]
        
        for cube in cubes {
          cube.isHidden = false
        }
        animatePlayerRoll(entrySize: 0.2, entryDuration: 1.5, entryPosition: -500)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
          self?.checkCombo()
        }
        onBoard = true
      } else {
        for index in 0...playerScores.count - 2 {
          if playerTakeScores[index] != true {
            playerScores[index] = 0
          }
        }
        
        yatzyView.rollButton.isEnabled = false
        
        animatePlayerRoll(entrySize: 5, entryDuration: 1.5, entryPosition: 100)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
          self?.rollAction()
        }
        onBoard = false
      }
      if rollCount == 5 {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
          self?.yatzyView.rollButton.isEnabled = false
        }
      }
    }
  }
  
  @objc func helpAction() {
    yatzyView.blurFrame.isHidden.toggle()
    yatzyView.comboGround.image = UIImage(named: "Combinations\(selectedCombo)")
    yatzyView.comboGround.isHidden.toggle()
    animateHelp(entrySize: 100, entryDuration: 0.75)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
      self?.yatzyView.rightButton.isHidden.toggle()
      self?.yatzyView.backButton.isHidden.toggle()
    }
  }
  
  @objc func helpBackAction() {
    animateHelp(entrySize: 0.01, entryDuration: 0.75)
    yatzyView.rightButton.isHidden.toggle()
    yatzyView.backButton.isHidden.toggle()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
      self?.yatzyView.blurFrame.isHidden.toggle()
      self?.yatzyView.comboGround.isHidden.toggle()
    }
  }
  
  @objc func rightAction() {
    if selectedCombo == 0 {
      selectedCombo += 1
    } else {
      selectedCombo = 0
    }
    yatzyView.comboGround.image = UIImage(named: "Combinations\(selectedCombo)")
  }
  
  @objc func startAction() {
    if yatzyView.betCount.text != nil && Int(yatzyView.betCount.text!) != nil {
      if MainData.shared.coins > 0 && Int(yatzyView.betCount.text!)! != 0 {
        yatzyView.yatzyBackButton.isHidden.toggle()
        yatzyView.blurFrame.isHidden.toggle()
        yatzyView.blurLabel.isHidden.toggle()
        yatzyView.startButton.isHidden.toggle()
        yatzyView.balanceGround.isHidden.toggle()
        yatzyView.betGround.isHidden.toggle()
        yatzyView.balanceLabel.isHidden.toggle()
        yatzyView.betCount.isHidden.toggle()
        
        for _ in 0...1 {
          yatzyView.betCount.isEnabled.toggle()
        }
        
        getBet()
        
        editButtons(value: true)
      }
    }
  }
  
  private func setupDelegate() {
    yatzyView.betCount.delegate = self
    
    yatzyView.collectionView.delegate = self
    yatzyView.collectionView.dataSource = self
  }
  
  private func editButtons(value: Bool) {
    let buttons = [yatzyView.pauseButton, yatzyView.rollButton, yatzyView.helpButton]
    
    for button in buttons {
      button.isEnabled = value
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
        yatzyView.balanceLabel.text = "\(thousands) 00\(coins)"
      } else if coins < 100 {
        yatzyView.balanceLabel.text = "\(thousands) 0\(coins)"
      } else {
        yatzyView.balanceLabel.text = "\(thousands) \(coins)"
      }
    } else {
      yatzyView.balanceLabel.text = "\(MainData.shared.coins)"
    }
  }
  
  private func setupStartBet() {
    if MainData.shared.coins < 100 {
      yatzyView.betCount.text = "\(MainData.shared.coins)"
    } else {
      yatzyView.betCount.text = "100"
    }
  }
  
  private func getBet() {
    if yatzyView.betCount.text != nil {
      YatzyData.shared.yatzyBet = Int(yatzyView.betCount.text!)!
      
      MainData.shared.coins -= YatzyData.shared.yatzyBet
      setupBalance()
    }
    UserDefaults.standard.set(MainData.shared.coins, forKey: "coin")
  }
  
  private func animateHelp(entrySize: CGFloat, entryDuration: Double) {
    let originalTransform = yatzyView.comboGround.transform
    let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.yatzyView.comboGround.transform = scaledAndTranslatedTransform
    })
  }
  
  private func animateTakeCube(cube: UIButton, entryPositionX: CGFloat, entryPositionY: CGFloat) {
    let originalTransform = cube.transform
    let scaledTransform = originalTransform.scaledBy(x: 1.0, y: 1.0)
    let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: entryPositionX, y: entryPositionY)
    UIView.animate(withDuration: 0.75, animations: {
      cube.transform = scaledAndTranslatedTransform
    })
  }
  
  private func animatePlayerRoll(entrySize: CGFloat, entryDuration: Double, entryPosition: CGFloat) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
      if self?.takeCubes[0] == 0 {
        self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
      }
      if self?.takeCubes[1] == 0 {
        self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
      }
      if self?.takeCubes[2] == 0 {
        self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
      }
      if self?.takeCubes[3] == 0 {
        self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
      }
      if self?.takeCubes[4] == 0 {
        self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
        if self?.takeCubes[0] == 0 {
          self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
        }
        if self?.takeCubes[1] == 0 {
          self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
        }
        if self?.takeCubes[2] == 0 {
          self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
        }
        if self?.takeCubes[3] == 0 {
          self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
        }
        if self?.takeCubes[4] == 0 {
          self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
          if self?.takeCubes[0] == 0 {
            self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
          }
          if self?.takeCubes[1] == 0 {
            self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
          }
          if self?.takeCubes[2] == 0 {
            self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
          }
          if self?.takeCubes[3] == 0 {
            self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
          }
          if self?.takeCubes[4] == 0 {
            self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            if self?.takeCubes[0] == 0 {
              self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
            }
            if self?.takeCubes[1] == 0 {
              self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
            }
            if self?.takeCubes[2] == 0 {
              self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
            }
            if self?.takeCubes[3] == 0 {
              self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
            }
            if self?.takeCubes[4] == 0 {
              self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
              if self?.takeCubes[0] == 0 {
                self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
              }
              if self?.takeCubes[1] == 0 {
                self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
              }
              if self?.takeCubes[2] == 0 {
                self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
              }
              if self?.takeCubes[3] == 0 {
                self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
              }
              if self?.takeCubes[4] == 0 {
                self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
              }
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                if self?.takeCubes[0] == 0 {
                  self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                }
                if self?.takeCubes[1] == 0 {
                  self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                }
                if self?.takeCubes[2] == 0 {
                  self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                }
                if self?.takeCubes[3] == 0 {
                  self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                }
                if self?.takeCubes[4] == 0 {
                  self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                  if self?.takeCubes[0] == 0 {
                    self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                  }
                  if self?.takeCubes[1] == 0 {
                    self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                  }
                  if self?.takeCubes[2] == 0 {
                    self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                  }
                  if self?.takeCubes[3] == 0 {
                    self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                  }
                  if self?.takeCubes[4] == 0 {
                    self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                  }
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                    if self?.takeCubes[0] == 0 {
                      self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                    }
                    if self?.takeCubes[1] == 0 {
                      self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                    }
                    if self?.takeCubes[2] == 0 {
                      self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                    }
                    if self?.takeCubes[3] == 0 {
                      self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                    }
                    if self?.takeCubes[4] == 0 {
                      self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                      if self?.takeCubes[0] == 0 {
                        self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                      }
                      if self?.takeCubes[1] == 0 {
                        self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                      }
                      if self?.takeCubes[2] == 0 {
                        self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                      }
                      if self?.takeCubes[3] == 0 {
                        self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                      }
                      if self?.takeCubes[4] == 0 {
                        self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                      }
                      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                        if self?.takeCubes[0] == 0 {
                          self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                        }
                        if self?.takeCubes[1] == 0 {
                          self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                        }
                        if self?.takeCubes[2] == 0 {
                          self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                        }
                        if self?.takeCubes[3] == 0 {
                          self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                        }
                        if self?.takeCubes[4] == 0 {
                          self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                          if self?.takeCubes[0] == 0 {
                            self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                          }
                          if self?.takeCubes[1] == 0 {
                            self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                          }
                          if self?.takeCubes[2] == 0 {
                            self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                          }
                          if self?.takeCubes[3] == 0 {
                            self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                          }
                          if self?.takeCubes[4] == 0 {
                            self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                          }
                          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                            if self?.takeCubes[0] == 0 {
                              self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                            }
                            if self?.takeCubes[1] == 0 {
                              self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                            }
                            if self?.takeCubes[2] == 0 {
                              self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                            }
                            if self?.takeCubes[3] == 0 {
                              self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                            }
                            if self?.takeCubes[4] == 0 {
                              self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                              if self?.takeCubes[0] == 0 {
                                self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                              }
                              if self?.takeCubes[1] == 0 {
                                self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                              }
                              if self?.takeCubes[2] == 0 {
                                self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                              }
                              if self?.takeCubes[3] == 0 {
                                self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                              }
                              if self?.takeCubes[4] == 0 {
                                self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                              }
                              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                                if self?.takeCubes[0] == 0 {
                                  self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                                }
                                if self?.takeCubes[1] == 0 {
                                  self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                                }
                                if self?.takeCubes[2] == 0 {
                                  self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                                }
                                if self?.takeCubes[3] == 0 {
                                  self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                                }
                                if self?.takeCubes[4] == 0 {
                                  self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                                  if self?.takeCubes[0] == 0 {
                                    let random = Int.random(in: 0...5)
                                    self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                                    self?.yatzyView.cube0.tag = 0
                                    self?.rollCubes[0] = random + 1
                                  }
                                  if self?.takeCubes[1] == 0 {
                                    let random = Int.random(in: 0...5)
                                    self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                                    self?.yatzyView.cube1.tag = 1
                                    self?.rollCubes[1] = random + 1
                                  }
                                  if self?.takeCubes[2] == 0 {
                                    let random = Int.random(in: 0...5)
                                    self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                                    self?.yatzyView.cube2.tag = 2
                                    self?.rollCubes[2] = random + 1
                                  }
                                  if self?.takeCubes[3] == 0 {
                                    let random = Int.random(in: 0...5)
                                    self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                                    self?.yatzyView.cube3.tag = 3
                                    self?.rollCubes[3] = random + 1
                                  }
                                  if self?.takeCubes[4] == 0 {
                                    let random = Int.random(in: 0...5)
                                    self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                                    self?.yatzyView.cube4.tag = 4
                                    self?.rollCubes[4] = random + 1
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    if takeCubes[0] == 0 {
      let originalTransform = yatzyView.cube0.transform
      let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: entryPosition)
      UIView.animate(withDuration: entryDuration, animations: {
        self.yatzyView.cube0.transform = scaledAndTranslatedTransform
      })
    }
    
    if takeCubes[1] == 0 {
      let originalTransform = yatzyView.cube1.transform
      let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: entryPosition)
      UIView.animate(withDuration: entryDuration, animations: {
        self.yatzyView.cube1.transform = scaledAndTranslatedTransform
      })
    }
    
    if takeCubes[2] == 0 {
      let originalTransform = yatzyView.cube2.transform
      let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: entryPosition)
      UIView.animate(withDuration: entryDuration, animations: {
        self.yatzyView.cube2.transform = scaledAndTranslatedTransform
      })
    }
    
    if takeCubes[3] == 0 {
      let originalTransform = yatzyView.cube3.transform
      let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: entryPosition)
      UIView.animate(withDuration: entryDuration, animations: {
        self.yatzyView.cube3.transform = scaledAndTranslatedTransform
      })
    }
    
    if takeCubes[4] == 0 {
      let originalTransform = yatzyView.cube4.transform
      let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: entryPosition)
      UIView.animate(withDuration: entryDuration, animations: {
        self.yatzyView.cube4.transform = scaledAndTranslatedTransform
      })
    }
  }
  
  private func animateEnemyRoll(entrySize: CGFloat, entryDuration: Double, entryPosition: CGFloat) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
      if self?.takeCubes[0] == 0 {
        self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
      }
      if self?.takeCubes[1] == 0 {
        self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
      }
      if self?.takeCubes[2] == 0 {
        self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
      }
      if self?.takeCubes[3] == 0 {
        self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
      }
      if self?.takeCubes[4] == 0 {
        self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
        if self?.takeCubes[0] == 0 {
          self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
        }
        if self?.takeCubes[1] == 0 {
          self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
        }
        if self?.takeCubes[2] == 0 {
          self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
        }
        if self?.takeCubes[3] == 0 {
          self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
        }
        if self?.takeCubes[4] == 0 {
          self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
          if self?.takeCubes[0] == 0 {
            self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
          }
          if self?.takeCubes[1] == 0 {
            self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
          }
          if self?.takeCubes[2] == 0 {
            self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
          }
          if self?.takeCubes[3] == 0 {
            self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
          }
          if self?.takeCubes[4] == 0 {
            self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            if self?.takeCubes[0] == 0 {
              self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
            }
            if self?.takeCubes[1] == 0 {
              self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
            }
            if self?.takeCubes[2] == 0 {
              self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
            }
            if self?.takeCubes[3] == 0 {
              self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
            }
            if self?.takeCubes[4] == 0 {
              self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
              if self?.takeCubes[0] == 0 {
                self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
              }
              if self?.takeCubes[1] == 0 {
                self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
              }
              if self?.takeCubes[2] == 0 {
                self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
              }
              if self?.takeCubes[3] == 0 {
                self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
              }
              if self?.takeCubes[4] == 0 {
                self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
              }
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                if self?.takeCubes[0] == 0 {
                  self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                }
                if self?.takeCubes[1] == 0 {
                  self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                }
                if self?.takeCubes[2] == 0 {
                  self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                }
                if self?.takeCubes[3] == 0 {
                  self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                }
                if self?.takeCubes[4] == 0 {
                  self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                  if self?.takeCubes[0] == 0 {
                    self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                  }
                  if self?.takeCubes[1] == 0 {
                    self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                  }
                  if self?.takeCubes[2] == 0 {
                    self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                  }
                  if self?.takeCubes[3] == 0 {
                    self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                  }
                  if self?.takeCubes[4] == 0 {
                    self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                  }
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                    if self?.takeCubes[0] == 0 {
                      self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                    }
                    if self?.takeCubes[1] == 0 {
                      self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                    }
                    if self?.takeCubes[2] == 0 {
                      self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                    }
                    if self?.takeCubes[3] == 0 {
                      self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                    }
                    if self?.takeCubes[4] == 0 {
                      self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                      if self?.takeCubes[0] == 0 {
                        self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                      }
                      if self?.takeCubes[1] == 0 {
                        self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                      }
                      if self?.takeCubes[2] == 0 {
                        self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                      }
                      if self?.takeCubes[3] == 0 {
                        self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                      }
                      if self?.takeCubes[4] == 0 {
                        self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                      }
                      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                        if self?.takeCubes[0] == 0 {
                          self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                        }
                        if self?.takeCubes[1] == 0 {
                          self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                        }
                        if self?.takeCubes[2] == 0 {
                          self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                        }
                        if self?.takeCubes[3] == 0 {
                          self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                        }
                        if self?.takeCubes[4] == 0 {
                          self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                          if self?.takeCubes[0] == 0 {
                            self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                          }
                          if self?.takeCubes[1] == 0 {
                            self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                          }
                          if self?.takeCubes[2] == 0 {
                            self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                          }
                          if self?.takeCubes[3] == 0 {
                            self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                          }
                          if self?.takeCubes[4] == 0 {
                            self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                          }
                          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                            if self?.takeCubes[0] == 0 {
                              self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                            }
                            if self?.takeCubes[1] == 0 {
                              self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                            }
                            if self?.takeCubes[2] == 0 {
                              self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                            }
                            if self?.takeCubes[3] == 0 {
                              self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                            }
                            if self?.takeCubes[4] == 0 {
                              self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                              if self?.takeCubes[0] == 0 {
                                self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                              }
                              if self?.takeCubes[1] == 0 {
                                self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                              }
                              if self?.takeCubes[2] == 0 {
                                self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                              }
                              if self?.takeCubes[3] == 0 {
                                self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                              }
                              if self?.takeCubes[4] == 0 {
                                self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                              }
                              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                                if self?.takeCubes[0] == 0 {
                                  self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                                }
                                if self?.takeCubes[1] == 0 {
                                  self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                                }
                                if self?.takeCubes[2] == 0 {
                                  self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                                }
                                if self?.takeCubes[3] == 0 {
                                  self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                                }
                                if self?.takeCubes[4] == 0 {
                                  self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(Int.random(in: 0...5))"), for: .normal)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                                  if self?.takeCubes[0] == 0 {
                                    let random = Int.random(in: 0...5)
                                    self?.yatzyView.cube0.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                                    self?.yatzyView.cube0.tag = 0
                                    self?.rollCubes[0] = random + 1
                                  }
                                  if self?.takeCubes[1] == 0 {
                                    let random = Int.random(in: 0...5)
                                    self?.yatzyView.cube1.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                                    self?.yatzyView.cube1.tag = 1
                                    self?.rollCubes[1] = random + 1
                                  }
                                  if self?.takeCubes[2] == 0 {
                                    let random = Int.random(in: 0...5)
                                    self?.yatzyView.cube2.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                                    self?.yatzyView.cube2.tag = 2
                                    self?.rollCubes[2] = random + 1
                                  }
                                  if self?.takeCubes[3] == 0 {
                                    let random = Int.random(in: 0...5)
                                    self?.yatzyView.cube3.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                                    self?.yatzyView.cube3.tag = 3
                                    self?.rollCubes[3] = random + 1
                                  }
                                  if self?.takeCubes[4] == 0 {
                                    let random = Int.random(in: 0...5)
                                    self?.yatzyView.cube4.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                                    self?.yatzyView.cube4.tag = 4
                                    self?.rollCubes[4] = random + 1
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    if takeCubes[0] == 0 {
      let originalTransform = yatzyView.cube0.transform
      let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: entryPosition)
      UIView.animate(withDuration: entryDuration, animations: {
        self.yatzyView.cube0.transform = scaledAndTranslatedTransform
      })
    }
    
    if takeCubes[1] == 0 {
      let originalTransform = yatzyView.cube1.transform
      let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: entryPosition)
      UIView.animate(withDuration: entryDuration, animations: {
        self.yatzyView.cube1.transform = scaledAndTranslatedTransform
      })
    }
    
    if takeCubes[2] == 0 {
      let originalTransform = yatzyView.cube2.transform
      let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: entryPosition)
      UIView.animate(withDuration: entryDuration, animations: {
        self.yatzyView.cube2.transform = scaledAndTranslatedTransform
      })
    }
    
    if takeCubes[3] == 0 {
      let originalTransform = yatzyView.cube3.transform
      let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: entryPosition)
      UIView.animate(withDuration: entryDuration, animations: {
        self.yatzyView.cube3.transform = scaledAndTranslatedTransform
      })
    }
    
    if takeCubes[4] == 0 {
      let originalTransform = yatzyView.cube4.transform
      let scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
      let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: entryPosition)
      UIView.animate(withDuration: entryDuration, animations: {
        self.yatzyView.cube4.transform = scaledAndTranslatedTransform
      })
    }
  }
  
  private func checkEnemyCombo() {
    let cubes = [yatzyView.cube0, yatzyView.cube1, yatzyView.cube2, yatzyView.cube3, yatzyView.cube4]
    var numbersCount = [0, 0, 0, 0, 0, 0]
    
    for index in 0...cubes.count - 1 {
      switch rollCubes[index] {
      case 1:
        numbersCount[0] += 1
      case 2:
        numbersCount[1] += 1
      case 3:
        numbersCount[2] += 1
      case 4:
        numbersCount[3] += 1
      case 5:
        numbersCount[4] += 1
      case 6:
        numbersCount[5] += 1
      default:
        print("Error: unowned tag")
      }
    }
    
    if numbersCount == [1, 1, 1, 1, 1, 0] && enemyTakeScores[11] != true  {
      enemyScores[11] = 30
    }
    
    if numbersCount == [0, 1, 1, 1, 1, 1] && enemyTakeScores[12] != true  {
      enemyScores[12] = 40
    }
    
    for index in 0...numbersCount.count - 1 {
      enemyScores[index] = (index + 1) * numbersCount[index]
      if enemyTakeScores[13] != true {
        enemyScores[13] += enemyScores[index]
      }
    }
    
    for index in 0...numbersCount.count - 1 {
      if numbersCount[index] == 3 && enemyTakeScores[8] != true  {
        enemyScores[8] = (index + 1) * 3
      } else if numbersCount[index] == 4 && enemyTakeScores[9] != true  {
        enemyScores[9] = (index + 1) * 4
      } else if numbersCount[index] == 5 && enemyTakeScores[14] != true  {
        enemyScores[14] = 50
      }
    }
    
    for index in 0...numbersCount.count - 1 {
      if numbersCount[index] == 3 {
        for index in 0...numbersCount.count - 1 {
          if numbersCount[index] == 2 && enemyTakeScores[10] != true  {
            enemyScores[10] = 25
          }
        }
      }
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
      self?.enemyAction(value: numbersCount)
    }
    
    yatzyView.collectionView.reloadData()
  }
  
  private func checkCombo() {
    let cubes = [yatzyView.cube0, yatzyView.cube1, yatzyView.cube2, yatzyView.cube3, yatzyView.cube4]
    var numbersCount = [0, 0, 0, 0, 0, 0]
    
    for index in 0...cubes.count - 1 {
      switch rollCubes[index] {
      case 1:
        numbersCount[0] += 1
      case 2:
        numbersCount[1] += 1
      case 3:
        numbersCount[2] += 1
      case 4:
        numbersCount[3] += 1
      case 5:
        numbersCount[4] += 1
      case 6:
        numbersCount[5] += 1
      default:
        print("Error: unowned tag")
      }
    }
    
    if numbersCount == [1, 1, 1, 1, 1, 0] && playerTakeScores[11] != true {
      playerScores[11] = 30
    }
    
    if numbersCount == [0, 1, 1, 1, 1, 1] && playerTakeScores[12] != true {
      playerScores[12] = 40
    }
    
    for index in 0...numbersCount.count - 1 {
      playerScores[index] = (index + 1) * numbersCount[index]
      if playerTakeScores[13] != true {
        playerScores[13] += playerScores[index]
      }
    }
    
    for index in 0...numbersCount.count - 1 {
      if numbersCount[index] == 3 && playerTakeScores[8] != true  {
        playerScores[8] = (index + 1) * 3
      } else if numbersCount[index] == 4 && playerTakeScores[9] != true  {
        playerScores[9] = (index + 1) * 4
      } else if numbersCount[index] == 5 && playerTakeScores[14] != true  {
        playerScores[14] = 50
      }
    }
    
    for index in 0...numbersCount.count - 1 {
      if numbersCount[index] == 3 {
        for index in 0...numbersCount.count - 1 {
          if numbersCount[index] == 2 && playerTakeScores[10] != true  {
            playerScores[10] = 25
          }
        }
      }
    }
    
    yatzyView.rollButton.isEnabled = true
    yatzyView.collectionView.reloadData()
  }
  
  private func swapTurn(value: TurnType) {
    onBoard = false
    if value == .player {
      turn = .enemy
      yatzyView.rollButton.isEnabled = false
      
      for index in 0...playerScores.count - 2 {
        if playerTakeScores[index] != true {
          playerScores[index] = 0
          yatzyView.collectionView.reloadData()
        }
      }
      
      for index in 0...takeCubes.count - 1 {
        if takeCubes[index] != 0 {
          let cubes = [yatzyView.cube0, yatzyView.cube1, yatzyView.cube2, yatzyView.cube3, yatzyView.cube4]
          
          switch cubes[index].tag {
          case 0:
            animateTakeCube(cube: cubes[index], entryPositionX: 0, entryPositionY: -115)
          case 1:
            animateTakeCube(cube: cubes[index], entryPositionX: -10, entryPositionY: -135)
          case 2:
            animateTakeCube(cube: cubes[index], entryPositionX: -20, entryPositionY: -120)
          case 3:
            animateTakeCube(cube: cubes[index], entryPositionX: -25, entryPositionY: -100)
          case 4:
            animateTakeCube(cube: cubes[index], entryPositionX: -30, entryPositionY: -115)
          default:
            animateTakeCube(cube: cubes[index], entryPositionX: 0, entryPositionY: 0)
          }
        }
      }
      
      rollCubes = [0, 0, 0, 0, 0]
      takeCubes = [0, 0, 0, 0, 0]
      rollCount = 0
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
        self?.animateEnemyRoll(entrySize: 5, entryDuration: 1.5, entryPosition: -100)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.55) { [weak self] in
          self?.enemyRollAction()
        }
      }
    } else {
      turnNumber += 1
      
      for index in 0...enemyScores.count - 1 {
        if index != enemyScores.count - 1 && enemyTakeScores[index] != true  {
          enemyScores[index] = 0
          yatzyView.collectionView.reloadData()
        }
      }
      
      for index in 0...takeCubes.count - 1 {
        if takeCubes[index] != 0 {
          let cubes = [yatzyView.cube0, yatzyView.cube1, yatzyView.cube2, yatzyView.cube3, yatzyView.cube4]
          
          switch cubes[index].tag {
          case 0:
            animateTakeCube(cube: cubes[index], entryPositionX: 0, entryPositionY: 115)
          case 1:
            animateTakeCube(cube: cubes[index], entryPositionX: -10, entryPositionY: 100)
          case 2:
            animateTakeCube(cube: cubes[index], entryPositionX: -20, entryPositionY: 120)
          case 3:
            animateTakeCube(cube: cubes[index], entryPositionX: -25, entryPositionY: 135)
          case 4:
            animateTakeCube(cube: cubes[index], entryPositionX: -30, entryPositionY: 115)
          default:
            animateTakeCube(cube: cubes[index], entryPositionX: 0, entryPositionY: 0)
          }
        }
      }
      
      rollCubes = [0, 0, 0, 0, 0]
      takeCubes = [0, 0, 0, 0, 0]
      rollCount = 0
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
        self?.animateEnemyRoll(entrySize: 5, entryDuration: 1.5, entryPosition: 100)
        self?.turn = .player
        if self?.turnNumber != nil {
          if self!.turnNumber >= 5 && self?.playerScore != self?.enemyScore {
            self?.yatzyView.rollButton.isEnabled = false
          } else {
            self?.yatzyView.rollButton.isEnabled = true
          }
        }
      }
      
      if turnNumber >= 5 && playerScore != enemyScore {
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [weak self] in
          self?.checkResult()
        }
      }
    }
  }
  
  private func checkResult() {
    if playerScores[15] > enemyScores[15] {
      yatzyView.result.isHidden = false
      yatzyView.result.image = UIImage(named: "YatzyWinScreen")
      yatzyView.menuButton.isHidden = false
      yatzyView.menuButton.setBackgroundImage(UIImage(named: "CollectButton"), for: .normal)
      yatzyView.winFrame.isHidden = false
      yatzyView.winFrame.image = UIImage(named: "WinFrame")
      yatzyView.winCount.text = "\(YatzyData.shared.yatzyBet * 2)"
      yatzyView.winCount.isHidden = false
      yatzyView.scoreCount.isHidden = false
      yatzyView.scoreCount.text = "\(playerScores[15])"
      yatzyView.scoreLeft.isHidden = false
      yatzyView.scoreRight.isHidden = false
      
      MainData.shared.coins += YatzyData.shared.yatzyBet * 2
    } else if enemyScores[15] > playerScores[15] {
      yatzyView.result.isHidden = false
      yatzyView.result.image = UIImage(named: "YatzyLoseScreen")
      yatzyView.menuButton.isHidden = false
      yatzyView.menuButton.setBackgroundImage(UIImage(named: "MenuButton"), for: .normal)
      yatzyView.restartButton.isHidden = false
      yatzyView.restartButton.setBackgroundImage(UIImage(named: "RestartButton"), for: .normal)
      yatzyView.scoreCount.isHidden = false
      yatzyView.scoreCount.text = "\(playerScores[15])"
      yatzyView.scoreLeft.isHidden = false
      yatzyView.scoreRight.isHidden = false
    }
    
    animateResult(entrySize: 10, entryDuration: 1.5)
    UserDefaults.standard.set(MainData.shared.coins, forKey: "coin")
  }
  
  private func animateResult(entrySize: CGFloat, entryDuration: Double) {
    var originalTransform = yatzyView.menuButton.transform
    var scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    var scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.yatzyView.menuButton.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = yatzyView.winFrame.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.yatzyView.winFrame.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = yatzyView.restartButton.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.yatzyView.restartButton.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = yatzyView.winCount.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.yatzyView.winCount.transform = scaledAndTranslatedTransform
    })
  }
  
  private func enemyAction(value: [Int]) {
    var comboCubies: [Int] = []
    
    for i in 0...value.count - 1 {
      if value[i] > 1 {
        comboCubies.append(i)
      }
    }
    
    if comboCubies.count != 0 {
      for i in 0...rollCubes.count - 1 {
        for j in 0...comboCubies.count - 1 {
          if rollCubes[i] == comboCubies[j] + 1 {
            if takeCubes[i] == 0 {
              enemyTakeCube(entryTag: i)
            }
          }
        }
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
        self?.enemyCheckCombo()
        self?.yatzyView.collectionView.reloadData()
      }
    } else {
      enemyCheckCombo()
    }
    
    yatzyView.collectionView.reloadData()
  }
  
  private func enemyCheckCombo() {
    if enemyScores[14] == 50 && enemyTakeScores[14] != true {
      enemyScore += enemyScores[14]
      enemyScores[comboNames.count - 1] += enemyScores[14]
      enemyTakeScores[14] = true
      enemySelected = 14
      
      swapTurn(value: turn)
    } else if enemyScores[12] == 40 && enemyTakeScores[12] != true {
      enemyScore += enemyScores[12]
      enemyScores[comboNames.count - 1] += enemyScores[12]
      enemyTakeScores[12] = true
      enemySelected = 12
      
      swapTurn(value: turn)
    } else if enemyScores[11] == 30 && enemyTakeScores[11] != true {
      enemyScore += enemyScores[11]
      enemyScores[comboNames.count - 1] += enemyScores[11]
      enemyTakeScores[11] = true
      enemySelected = 11
      
      swapTurn(value: turn)
    } else if enemyScores[10] == 25 && enemyTakeScores[10] != true {
      enemyScore += enemyScores[10]
      enemyScores[comboNames.count - 1] += enemyScores[10]
      enemyTakeScores[10] = true
      enemySelected = 10
      
      swapTurn(value: turn)
    } else if enemyScores[9] != 0 && enemyTakeScores[9] != true {
      enemyScore += enemyScores[9]
      enemyScores[comboNames.count - 1] += enemyScores[9]
      enemyTakeScores[9] = true
      enemySelected = 9
      
      swapTurn(value: turn)
    } else if enemyScores[8] != 0 && enemyTakeScores[8] != true {
      enemyScore += enemyScores[8]
      enemyScores[comboNames.count - 1] += enemyScores[8]
      enemyTakeScores[8] = true
      enemySelected = 8
      
      swapTurn(value: turn)
    } else if enemyScores[13] + enemyScore > playerScores[comboNames.count - 1] && enemyTakeScores[13] != true {
      enemyScore += enemyScores[13]
      enemyScores[comboNames.count - 1] += enemyScores[13]
      enemyTakeScores[13] = true
      enemySelected = 13
      
      swapTurn(value: turn)
    } else if rollCount != 5 {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
        self?.enemyRollAction()
      }
    } else if enemyTakeScores[13] != true {
      enemyScore += enemyScores[13]
      enemyScores[comboNames.count - 1] += enemyScores[13]
      enemyTakeScores[13] = true
      enemySelected = 13
      
      swapTurn(value: turn)
    } else if enemyScores[0] != 0 && enemyTakeScores[0] != true {
      enemyScore += enemyScores[0]
      enemyScores[comboNames.count - 1] += enemyScores[0]
      enemyTakeScores[0] = true
      enemySelected = 0
      
      swapTurn(value: turn)
    } else if enemyScores[1] != 0 && enemyTakeScores[1] != true {
      enemyScore += enemyScores[1]
      enemyScores[comboNames.count - 1] += enemyScores[1]
      enemyTakeScores[1] = true
      enemySelected = 1
      
      swapTurn(value: turn)
    } else if enemyScores[2] != 0 && enemyTakeScores[2] != true {
      enemyScore += enemyScores[2]
      enemyScores[comboNames.count - 1] += enemyScores[2]
      enemyTakeScores[2] = true
      enemySelected = 2
      
      swapTurn(value: turn)
    } else if enemyScores[3] != 0 && enemyTakeScores[3] != true {
      enemyScore += enemyScores[3]
      enemyScores[comboNames.count - 1] += enemyScores[3]
      enemyTakeScores[3] = true
      enemySelected = 3
      
      swapTurn(value: turn)
    } else if enemyScores[4] != 0 && enemyTakeScores[4] != true {
      enemyScore += enemyScores[4]
      enemyScores[comboNames.count - 1] += enemyScores[4]
      enemyTakeScores[4] = true
      enemySelected = 4
      
      swapTurn(value: turn)
    } else if enemyScores[5] != 0 && enemyTakeScores[5] != true {
      enemyScore += enemyScores[5]
      enemyScores[comboNames.count - 1] += enemyScores[5]
      enemyTakeScores[5] = true
      enemySelected = 5
      
      swapTurn(value: turn)
    }
  }
}

extension YatzyViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField.text != nil {
      var count: Int?
      count = Int(textField.text!)
      
      if count != nil {
        if count! > MainData.shared.coins {
          count = MainData.shared.coins
          textField.text = "\(count!)"
        }
        
        YatzyData.shared.yatzyBet = count!
      } else {
        count = 1
        textField.text = "\(count!)"
        
        YatzyData.shared.yatzyBet = count!
      }
    }
  }
}

extension YatzyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return comboNames.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YatzyCollectionViewCell.id, for: indexPath) as? YatzyCollectionViewCell
    else {
      fatalError("init(coder:) has not been implemented")
    }
    
    if indexPath.row == playerSelected {
      cell.playerCheck.image = UIImage(named: "Check1")
      cell.playerCheck.isHidden = false
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
        self?.playerSelected = -1
      }
    } else {
      if playerScores[indexPath.row] != 0 && indexPath.row != comboNames.count - 1 {
        cell.playerCheck.isHidden = false
        cell.playerCheck.image = UIImage(named: "Check0")
      } else {
        if indexPath.row != playerSelected {
          cell.playerCheck.isHidden = true
        }
      }
    }
    
    if playerTakeScores[indexPath.row] {
      cell.playerCheck.image = UIImage(named: "Check1")
      cell.playerCheck.isHidden = false
    }
    
    if indexPath.row == enemySelected {
      cell.enemyCheck.image = UIImage(named: "Check1")
      cell.enemyCheck.isHidden = false
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
        self?.enemySelected = -1
      }
    } else {
      if enemyScores[indexPath.row] != 0 && indexPath.row != comboNames.count - 1 {
        cell.enemyCheck.isHidden = false
        cell.enemyCheck.image = UIImage(named: "Check0")
      } else {
        if indexPath.row != enemySelected {
          cell.enemyCheck.isHidden = true
        }
      }
    }
    
    if enemyTakeScores[indexPath.row] {
      cell.enemyCheck.image = UIImage(named: "Check1")
      cell.enemyCheck.isHidden = false
    }
    
    if playerScores[indexPath.row] != 0 && indexPath.row != comboNames.count - 1 {
      cell.player.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    } else {
      cell.player.textColor = #colorLiteral(red: 0.1725490196, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    }
    
    if enemyScores[indexPath.row] != 0 && indexPath.row != comboNames.count - 1 {
      cell.enemy.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    } else {
      cell.enemy.textColor = #colorLiteral(red: 0.1725490196, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    }
    
    if indexPath.row == comboNames.count - 1 {
      cell.player.text = "\(playerScore)"
      cell.enemy.text = "\(enemyScore)"
    }
    
    cell.name.text = comboNames[indexPath.row]
    cell.player.text = "\(playerScores[indexPath.row])"
    cell.enemy.text = "\(enemyScores[indexPath.row])"
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if turn == .player {
      if playerScores[indexPath.row] != 0 && indexPath.row != comboNames.count - 1 && playerTakeScores[indexPath.row] != true {
        playerScores[comboNames.count - 1] += playerScores[indexPath.row]
        playerTakeScores[indexPath.row] = true
        
        playerSelected = indexPath.row
        swapTurn(value: turn)
        collectionView.reloadData()
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.row == 15 {
      return CGSize(width: yatzyView.list.frame.width, height: 40)
    } else {
      return CGSize(width: yatzyView.list.frame.width, height: 19.15)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
}
