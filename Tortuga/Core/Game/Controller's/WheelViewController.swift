import UIKit

class WheelViewController: UIViewController {
  private var wheelView: WheelView!
  private let device = UIDevice()
  
  public var selected: Int = 1
  
  private var lightWin: Int = 0
  private var mediumWin: Int = 0
  private var hardWin: Int = 0
  
  private var score: Int = 0
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupController()
    setupView()
    
    setupTargets()
    
    checkSelected()
    animateResult(entrySize: 0.1, entryDuration: 0.01)
  }
  
  private func setupController() {
    navigationItem.hidesBackButton = true
  }
  
  private func setupView() {
    wheelView = WheelView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    wheelView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(wheelView)
    
    let constraints = [
      wheelView.leftAnchor.constraint(equalTo: view.leftAnchor),
      wheelView.rightAnchor.constraint(equalTo: view.rightAnchor),
      wheelView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      wheelView.topAnchor.constraint(equalTo: view.topAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
  }
  
  private func setupTargets() {
    wheelView.backButton.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
    wheelView.spinButton.addTarget(self, action: #selector(spinAction), for: .touchUpInside)
    wheelView.menuButton.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
    wheelView.restartButton.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
  }
  
  @objc func restartAction() {
    lightWin = 0
    mediumWin = 0
    hardWin = 0
    score = 0
    
    viewDidLoad()
  }
  
  @objc func menuAction() {
    navigationController?.popViewController(animated: true)
  }
  
  private func checkSelected() {
    switch selected {
    case 0:
      wheelView.mediumButton.image = UIImage(named: "Light")
      
      wheelView.wheelArrow0.isHidden = false
      wheelView.wheelArrow1.isHidden = true
      wheelView.wheelArrow2.isHidden = true
      
      wheelView.wheel0.image = UIImage(named: "Wheel0")
      wheelView.wheel1.image = UIImage(named: "Wheel1Lock")
      wheelView.wheel2.image = UIImage(named: "Wheel2Lock")
      
      if device.model == .iPhone8 || device.model == .iPhone8Plus {
        let constraints = [
          wheelView.mediumButton.widthAnchor.constraint(equalToConstant: 194 * 0.75),
          wheelView.mediumButton.heightAnchor.constraint(equalToConstant: 172 * 0.75),
        ]
        NSLayoutConstraint.activate(constraints)
      } 
    case 1:
      wheelView.mediumButton.image = UIImage(named: "Medium")
      
      wheelView.wheelArrow0.isHidden = true
      wheelView.wheelArrow1.isHidden = false
      wheelView.wheelArrow2.isHidden = true
      
      wheelView.wheel0.image = UIImage(named: "Wheel0")
      wheelView.wheel1.image = UIImage(named: "Wheel1")
      wheelView.wheel2.image = UIImage(named: "Wheel2Lock")
      
      if device.model == .iPhone8 || device.model == .iPhone8Plus {
        let constraints = [
          wheelView.mediumButton.widthAnchor.constraint(equalToConstant: 255 * 0.75),
          wheelView.mediumButton.heightAnchor.constraint(equalToConstant: 171 * 0.75),
        ]
        NSLayoutConstraint.activate(constraints)
      }
    case 2:
      wheelView.mediumButton.image = UIImage(named: "Hard")
      
      wheelView.wheelArrow0.isHidden = true
      wheelView.wheelArrow1.isHidden = true
      wheelView.wheelArrow2.isHidden = false
      
      wheelView.wheel0.image = UIImage(named: "Wheel0")
      wheelView.wheel1.image = UIImage(named: "Wheel1")
      wheelView.wheel2.image = UIImage(named: "Wheel2")
      
      if device.model == .iPhone8 || device.model == .iPhone8Plus {
        let constraints = [
          wheelView.mediumButton.widthAnchor.constraint(equalToConstant: 183 * 0.75),
          wheelView.mediumButton.heightAnchor.constraint(equalToConstant: 175 * 0.75),
        ]
        NSLayoutConstraint.activate(constraints)
      }
    default:
      print("Error: unwoned")
    }
  }
  
  private func lightSpin() {
    let rand = Int.random(in: 0...8)
    UIView.animate(withDuration: 1, delay: 0, options: .curveLinear){
      self.wheelView.wheel0.transform = self.wheelView.wheel0.transform.rotated(by: .pi)
    } completion: { _ in
      UIView.animate(withDuration: 1, delay: 0, options: .curveLinear){
        self.wheelView.wheel0.transform = self.wheelView.wheel0.transform.rotated(by: .pi)
      } completion: { _ in
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) {
          self.wheelView.wheel0.transform = CGAffineTransform(
            rotationAngle: (.pi / 4.5) * CGFloat(rand))
        } completion: { [self] _ in
          switch rand {
          case 0:
            self.lightWin = 100
          case 1:
            self.lightWin = 150
          case 2:
            self.lightWin = 500
          case 3:
            self.lightWin = 130
          case 4:
            self.lightWin = 200
          case 5:
            self.lightWin = 100
          case 6:
            self.lightWin = 150
          case 7:
            self.lightWin = 130
          case 8:
            self.lightWin = 200
          default:
            print("Error: unowned")
          }
        }
      }
    }
  }
  
  private func mediumSpin() {
    let rand = Int.random(in: 0...17)
    UIView.animate(withDuration: 1, delay: 0, options: .curveLinear){
      self.wheelView.wheel1.transform = self.wheelView.wheel1.transform.rotated(by: .pi)
    } completion: { _ in
      UIView.animate(withDuration: 1, delay: 0, options: .curveLinear){
        self.wheelView.wheel1.transform = self.wheelView.wheel1.transform.rotated(by: .pi)
      } completion: { _ in
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) {
          self.wheelView.wheel1.transform = CGAffineTransform(
            rotationAngle: (.pi / 9) * CGFloat(rand))
        } completion: { [self] _ in
          switch rand {
          case 0:
            self.mediumWin = 0
          case 1:
            self.mediumWin = 5
          case 2:
            self.mediumWin = 2
          case 3:
            self.mediumWin = 3
          case 4:
            self.mediumWin = 1
          case 5:
            self.mediumWin = 4
          case 6:
            self.mediumWin = 0
          case 7:
            self.mediumWin = 5
          case 8:
            self.mediumWin = 2
          case 9:
            self.mediumWin = 3
          case 10:
            self.mediumWin = 1
          case 11:
            self.mediumWin = 4
          case 12:
            self.mediumWin = 0
          case 13:
            self.mediumWin = 5
          case 14:
            self.mediumWin = 2
          case 15:
            self.mediumWin = 3
          case 16:
            self.mediumWin = 1
          case 17:
            self.mediumWin = 4
          default:
            print("Error: unowned")
          }
        }
      }
    }
  }
  
  private func hardSpin() {
    let rand = Int.random(in: 0...17)
    UIView.animate(withDuration: 1, delay: 0, options: .curveLinear){
      self.wheelView.wheel2.transform = self.wheelView.wheel2.transform.rotated(by: .pi)
    } completion: { _ in
      UIView.animate(withDuration: 1, delay: 0, options: .curveLinear){
        self.wheelView.wheel2.transform = self.wheelView.wheel2.transform.rotated(by: .pi)
      } completion: { _ in
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) {
          self.wheelView.wheel2.transform = CGAffineTransform(
            rotationAngle: (.pi / 9) * CGFloat(rand))
        } completion: { [self] _ in
          switch rand {
          case 0:
            self.hardWin = 100
          case 1:
            self.hardWin = 0
          case 2:
            self.hardWin = 600
          case 3:
            self.hardWin = 200
          case 4:
            self.hardWin = 400
          case 5:
            self.hardWin = 0
          case 6:
            self.hardWin = 900
          case 7:
            self.hardWin = 100
          case 8:
            self.hardWin = 200
          case 9:
            self.hardWin = 0
          case 10:
            self.hardWin = 700
          case 11:
            self.hardWin = 400
          case 12:
            self.hardWin = 500
          case 13:
            self.hardWin = 0
          case 14:
            self.hardWin = 300
          case 15:
            self.hardWin = 0
          case 16:
            self.hardWin = 800
          case 17:
            self.hardWin = 500
          default:
            print("Error: unowned")
          }
        }
      }
    }
  }
  
  @objc func spinAction() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { 
      SoundPlayer.shared.wheelSound()
    }
    
    if selected == 0 {
      if MainData.shared.coins >= 250 {
        MainData.shared.coins -= 250
        UserDefaults.standard.set(MainData.shared.coins, forKey: "coin")
        lightSpin()
      }
    } else if selected == 1 {
      if MainData.shared.coins >= 500 {
        MainData.shared.coins -= 500
        UserDefaults.standard.set(MainData.shared.coins, forKey: "coin")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
          self?.lightSpin()
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.mediumSpin()
          }
        }
      }
    } else if selected == 2 {
      if MainData.shared.coins >= 1000 {
        MainData.shared.coins -= 1000
        UserDefaults.standard.set(MainData.shared.coins, forKey: "coin")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
          self?.lightSpin()
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.mediumSpin()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
              self?.hardSpin()
            }
          }
        }
      }
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [weak self] in
      self?.checkResult()
    }
  }
  
  private func checkResult() {
    var win = true
    
    if selected == 0 {
      score = lightWin
    } else if selected == 1 {
      score = lightWin * mediumWin
    } else if selected == 2 {
      score = (lightWin + hardWin) * mediumWin
    }
    
    if selected >= 1 && mediumWin == 0 {
      win = false
    } else {
      win = true
    }
    
    if win {
      wheelView.result.isHidden = false
      wheelView.result.image = UIImage(named: "WheelWinScreen")
      wheelView.menuButton.isHidden = false
      wheelView.menuButton.setBackgroundImage(UIImage(named: "CollectButton"), for: .normal)
      wheelView.winFrame.isHidden = false
      wheelView.winFrame.image = UIImage(named: "WinFrame")
      wheelView.winCount.text = "\(score)"
      wheelView.winCount.isHidden = false
      
      MainData.shared.coins += score
      UserDefaults.standard.set(MainData.shared.coins, forKey: "coin")
    } else {
      wheelView.result.isHidden = false
      wheelView.result.image = UIImage(named: "WheelLoseScreen")
      wheelView.menuButton.isHidden = false
      wheelView.menuButton.setBackgroundImage(UIImage(named: "MenuButton"), for: .normal)
      switch selected {
      case 0:
        if MainData.shared.coins < 250 {
          wheelView.restartButton.isEnabled = false
        } else {
          wheelView.restartButton.isEnabled = true
        }
      case 1:
        if MainData.shared.coins < 500 {
          wheelView.restartButton.isEnabled = false
        } else {
          wheelView.restartButton.isEnabled = true
        }
      case 2:
        if MainData.shared.coins < 1000 {
          wheelView.restartButton.isEnabled = false
        } else {
          wheelView.restartButton.isEnabled = true
        }
      default:
        print("Error: unwoned")
      }
      wheelView.restartButton.isHidden = false
      wheelView.restartButton.setBackgroundImage(UIImage(named: "RestartButton"), for: .normal)
    }
    
    animateResult(entrySize: 10, entryDuration: 1.5)
  }
  
  private func animateResult(entrySize: CGFloat, entryDuration: Double) {
    var originalTransform = wheelView.menuButton.transform
    var scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    var scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.wheelView.menuButton.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = wheelView.winFrame.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.wheelView.winFrame.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = wheelView.restartButton.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.wheelView.restartButton.transform = scaledAndTranslatedTransform
    })
    
    originalTransform = wheelView.winCount.transform
    scaledTransform = originalTransform.scaledBy(x: entrySize, y: entrySize)
    scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 0.0)
    UIView.animate(withDuration: entryDuration, animations: {
      self.wheelView.winCount.transform = scaledAndTranslatedTransform
    })
  }
}
