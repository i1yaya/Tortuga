import UIKit

class DiceViewController: UIViewController {
  private var diceView: DiceView!
  private var pauseView: PauseView!
  
  private var cube: Int = 0
  private var count: Int = 1
  
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
    
    animateCubes(entrySize: 1, entryDuration: 0.01, entryPosition: -15)
    animateResult(entrySize: 0.1, entryDuration: 0.01)
  }
  
  private func setupController() {
    navigationItem.hidesBackButton = true
  }
  
  private func setupView() {
    diceView = DiceView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    diceView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(diceView)
    
    let constraints = [
      diceView.leftAnchor.constraint(equalTo: view.leftAnchor),
      diceView.rightAnchor.constraint(equalTo: view.rightAnchor),
      diceView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      diceView.topAnchor.constraint(equalTo: view.topAnchor)
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
    diceView.pauseButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
    diceView.rollButton.addTarget(self, action: #selector(rollAction), for: .touchUpInside)
    diceView.bidButton.addTarget(self, action: #selector(bidAction), for: .touchUpInside)
    pauseView.resumeButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
    pauseView.replayButton.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
    pauseView.menuButton.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
    diceView.cubeUpButton.addTarget(self, action: #selector(upCube), for: .touchUpInside)
    diceView.cubeDownButton.addTarget(self, action: #selector(downCube), for: .touchUpInside)
    diceView.countUpButton.addTarget(self, action: #selector(upCount), for: .touchUpInside)
    diceView.countDownButton.addTarget(self, action: #selector(downCount), for: .touchUpInside)
    diceView.restartButton.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
    diceView.menuButton.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
  }
  
  private func setupDelegate() {
    diceView.betCount.delegate = self
  }
  
  @objc func pauseAction() {
    pauseView.isHidden.toggle()
  }
  
  @objc func rollAction() {
    if diceView.betCount.text != nil && Int(diceView.betCount.text!) != nil {
      if MainData.shared.coins > 0 && Int(diceView.betCount.text!)! != 0 {
        diceView.ground.isHidden = false
        diceView.rollButton.isHidden = true
        
        diceView.betCount.isEnabled = false
        diceView.bidButton.isHidden = false
        diceView.bidGround.isHidden = false
        diceView.cubeGround.isHidden = false
        diceView.countGround.isHidden = false
        diceView.cubeUpButton.isHidden = false
        diceView.cubeDownButton.isHidden = false
        diceView.countUpButton.isHidden = false
        diceView.countDownButton.isHidden = false
        diceView.count.isHidden = false
        diceView.cube.isHidden = false
        
        getBet()
      }
    }
  }
  
  @objc func bidAction() {
    
    rollAnimate()
    
    diceView.ground.isHidden = true
    
    diceView.betCount.isEnabled = true
    diceView.bidButton.isHidden = true
    diceView.bidGround.isHidden = true
    diceView.cubeGround.isHidden = true
    diceView.countGround.isHidden = true
    diceView.cubeUpButton.isHidden = true
    diceView.cubeDownButton.isHidden = true
    diceView.countUpButton.isHidden = true
    diceView.countDownButton.isHidden = true
    diceView.count.isHidden = true
    diceView.cube.isHidden = true
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.55) { [weak self] in
      
      self?.animateCubes(entrySize: 1, entryDuration: 0.75, entryPosition: 30)
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
        let cubes = [self?.diceView.cube0, self?.diceView.cube1, self?.diceView.cube2, self?.diceView.cube3, self?.diceView.cube4]
        
        for cub in cubes {
          cub!.isHidden = false
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            SoundPlayer.shared.cubeSound()
          }
        }
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.75) { [weak self] in
        self?.checkResult()
      }
    }
  }
  
  private func rollAnimate() {
    UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
      self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: .pi/10)
    } completion: { _ in
      UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
        self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: -.pi/10)
      } completion: { _ in
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
          self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: .pi/10)
        } completion: { _ in
          UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
            self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: -.pi/10)
          } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
              self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: .pi/10)
            } completion: { _ in
              UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
                self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: -.pi/10)
              } completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
                  self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: .pi/10)
                } completion: { _ in
                  UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
                    self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: -.pi/10)
                  } completion: { _ in
                    UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
                      self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: -.pi/10)
                    } completion: { _ in
                      UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
                        self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: .pi/10)
                      } completion: { _ in
                        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
                          self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: -.pi/10)
                        } completion: { _ in
                          UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
                            self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: .pi/10)
                          } completion: { _ in
                            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear){
                              self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: -.pi/10)
                            } completion: { _ in
                              
                              UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear){
                                self.diceView.cup0.transform = self.diceView.cup0.transform.rotated(by: .pi/1.5)
                              } completion: { _ in
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
  
  private func checkResult() {
    if checkCubes() {
      diceView.result.isHidden = false
      diceView.result.image = UIImage(named: "DiceWinScreen")
      diceView.menuButton.isHidden = false
      diceView.menuButton.setBackgroundImage(UIImage(named: "CollectButton"), for: .normal)
      diceView.winFrame.isHidden = false
      diceView.winFrame.image = UIImage(named: "WinFrame")
      diceView.winCount.text = "\(DiceData.shared.diceBet * 2)"
      diceView.winCount.isHidden = false
      
      MainData.shared.coins += DiceData.shared.diceBet * 2
    } else {
      diceView.result.isHidden = false
      diceView.result.image = UIImage(named: "DiceLoseScreen")
      diceView.menuButton.isHidden = false
      diceView.menuButton.setBackgroundImage(UIImage(named: "MenuButton"), for: .normal)
      diceView.restartButton.isHidden = false
      diceView.restartButton.setBackgroundImage(UIImage(named: "RestartButton"), for: .normal)
    }
    
    animateResult(entrySize: 10, entryDuration: 1.5)
    UserDefaults.standard.set(MainData.shared.coins, forKey: "coin")
  }
  
  @objc func upCube() {
    if cube < 5 {
      cube += 1
    } else {
      cube = 0
    }
    diceView.cube.image = UIImage(named: "Dice\(cube)")
  }
  
  @objc func downCube() {
    if cube > 0 {
      cube -= 1
    } else {
      cube = 5
    }
    diceView.cube.image = UIImage(named: "Dice\(cube)")
  }
  
  @objc func upCount() {
    if count < 5 {
      count += 1
    } else {
      count = 1
    }
    diceView.count.text = "\(count)"
  }
  
  @objc func downCount() {
    if count > 1 {
      count -= 1
    } else {
      count = 5
    }
    diceView.count.text = "\(count)"
  }
  
  @objc func menuAction() {
    navigationController?.popViewController(animated: true)
    
    cube = 0
    count = 1
  }
  
  @objc func restartAction() {
    viewDidLoad()
    
    cube = 0
    count = 1
  }
  
  private func checkCubes() -> Bool {
    let cubes = [diceView.cube0, diceView.cube1, diceView.cube2, diceView.cube3, diceView.cube4]
    var numbersCount = [0, 0, 0, 0, 0, 0]
    
    for index in 0...cubes.count - 1 {
      switch cubes[index].tag {
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
    
    if numbersCount[cube] == count {
      return true
    } else {
      return false
    }
  }
  
  private func setupBalance() {
    if MainData.shared.coins / 1000 > 0 {
      let thousands = MainData.shared.coins / 1000
      let coins = MainData.shared.coins - (thousands * 1000)
      if coins < 10 {
        diceView.balanceLabel.text = "\(thousands) 00\(coins)"
      } else if coins < 100 {
        diceView.balanceLabel.text = "\(thousands) 0\(coins)"
      } else {
        diceView.balanceLabel.text = "\(thousands) \(coins)"
      }
    } else {
      diceView.balanceLabel.text = "\(MainData.shared.coins)"
    }
  }
  
  private func setupStartBet() {
    if MainData.shared.coins < 100 {
      diceView.betCount.text = "\(MainData.shared.coins)"
    } else {
      diceView.betCount.text = "100"
    }
  }
  
  private func getBet() {
    if diceView.betCount.text != nil && Int(diceView.betCount.text!) != nil {
      DiceData.shared.diceBet = Int(diceView.betCount.text!)!
      
      MainData.shared.coins -= DiceData.shared.diceBet
      setupBalance()
    }
    UserDefaults.standard.set(MainData.shared.coins, forKey: "coin")
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  private func animateCubes(entrySize: CGFloat, entryDuration: Double, entryPosition: CGFloat) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
      let random = Int.random(in: 0...5)
      self?.diceView.cube0.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
      self?.diceView.cube1.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
      self?.diceView.cube2.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
      self?.diceView.cube3.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
      self?.diceView.cube4.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
        let random = Int.random(in: 0...5)
        self?.diceView.cube0.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
        self?.diceView.cube1.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
        self?.diceView.cube2.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
        self?.diceView.cube3.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
        self?.diceView.cube4.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
          let random = Int.random(in: 0...5)
          self?.diceView.cube0.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
          self?.diceView.cube1.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
          self?.diceView.cube2.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
          self?.diceView.cube3.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
          self?.diceView.cube4.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            let random = Int.random(in: 0...5)
            self?.diceView.cube0.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
            self?.diceView.cube1.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
            self?.diceView.cube2.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
            self?.diceView.cube3.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
            self?.diceView.cube4.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
              let random = Int.random(in: 0...5)
              self?.diceView.cube0.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
              self?.diceView.cube1.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
              self?.diceView.cube2.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
              self?.diceView.cube3.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
              self?.diceView.cube4.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                let random = Int.random(in: 0...5)
                self?.diceView.cube0.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                self?.diceView.cube1.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                self?.diceView.cube2.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                self?.diceView.cube3.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                self?.diceView.cube4.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in
                  var random = Int.random(in: 0...5)
                  self?.diceView.cube0.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                  self?.diceView.cube0.tag = random + 1
                  random = Int.random(in: 0...5)
                  self?.diceView.cube1.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                  self?.diceView.cube1.tag = random + 1
                  random = Int.random(in: 0...5)
                  self?.diceView.cube2.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                  self?.diceView.cube2.tag = random + 1
                  random = Int.random(in: 0...5)
                  self?.diceView.cube3.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                  self?.diceView.cube3.tag = random + 1
                  random = Int.random(in: 0...5)
                  self?.diceView.cube4.setBackgroundImage(UIImage(named: "Cube\(random)"), for: .normal)
                  self?.diceView.cube4.tag = random + 1
                }
              }
            }
          }
        }
      }
    }
    
    var originalTransform = diceView.cube0.transform
    var scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    var scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 150.0, y: entryPosition)
    UIView.animate(withDuration: entryDuration, animations: {
      self.diceView.cube0.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = diceView.cube1.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 150.0, y: entryPosition)
    UIView.animate(withDuration: entryDuration, animations: {
      self.diceView.cube1.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = diceView.cube2.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 150.0, y: entryPosition)
    UIView.animate(withDuration: entryDuration, animations: {
      self.diceView.cube2.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = diceView.cube3.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 150.0, y: entryPosition)
    UIView.animate(withDuration: entryDuration, animations: {
      self.diceView.cube3.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = diceView.cube4.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 150.0, y: entryPosition)
    UIView.animate(withDuration: entryDuration, animations: {
      self.diceView.cube4.transform = scaledAndTranslatedTransform
    })
  }
  
  private func animateResult(entrySize: CGFloat, entryDuration: Double) {
    var originalTransform = diceView.menuButton.transform
    var scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    var scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.diceView.menuButton.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = diceView.winFrame.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.diceView.winFrame.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = diceView.restartButton.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.diceView.restartButton.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = diceView.winCount.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.diceView.winCount.transform = scaledAndTranslatedTransform
    })
  }
}

extension DiceViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField.text != nil {
      var count: Int?
      count = Int(textField.text!)
      
      if count != nil {
        if count! > MainData.shared.coins {
          count = MainData.shared.coins
          textField.text = "\(count!)"
        }
        
        DiceData.shared.diceBet = count!
      } else {
        count = 1
        textField.text = "\(count!)"
        
        DiceData.shared.diceBet = count!
      }
    }
  }
}
