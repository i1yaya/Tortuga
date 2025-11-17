import UIKit

class WheelView: UIView {
  public let background: UIImageView = {
    let image = UIImage(named: "WheelBackground")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let backButton: UIButton = {
    let image = UIImage(named: "BackButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let price: UIImageView = {
    let image = UIImage(named: "WheelPrice")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let light: UIImageView = {
    let image = UIImage(named: "WheelLight")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let spinButton: UIButton = {
    let image = UIImage(named: "SpinButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let wheel2: UIImageView = {
    let image = UIImage(named: "Wheel2")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let wheel1: UIImageView = {
    let image = UIImage(named: "Wheel1")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let wheel0: UIImageView = {
    let image = UIImage(named: "Wheel0")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let wheelLabel: UIImageView = {
    let image = UIImage(named: "WheelLabel")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let wheelArrow2: UIImageView = {
    let image = UIImage(named: "WheelArrow2")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let wheelArrow1: UIImageView = {
    let image = UIImage(named: "WheelArrow1")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let wheelArrow0: UIImageView = {
    let image = UIImage(named: "WheelArrow0")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let mediumButton: UIImageView = {
    let image = UIImage(named: "Medium")
    let imageView = UIImageView(image: image)
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
    addSubview(backButton)
    addSubview(price)
    addSubview(light)
    addSubview(spinButton)
    addSubview(wheel2)
    addSubview(wheel1)
    addSubview(wheel0)
    addSubview(wheelLabel)
    addSubview(wheelArrow2)
    addSubview(wheelArrow1)
    addSubview(wheelArrow0)
    addSubview(mediumButton)
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
      
      backButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
      backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      
      price.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
      price.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      
      light.centerYAnchor.constraint(equalTo: mediumButton.centerYAnchor, constant: -5),
      light.rightAnchor.constraint(equalTo: centerXAnchor, constant: -50),
      
      spinButton.centerYAnchor.constraint(equalTo: wheel2.centerYAnchor),
      spinButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
      
      wheel0.centerYAnchor.constraint(equalTo: wheel2.centerYAnchor),
      wheel0.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      wheel1.centerYAnchor.constraint(equalTo: wheel2.centerYAnchor),
      wheel1.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      wheel2.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 15),
      wheel2.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      wheelLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      wheelLabel.topAnchor.constraint(equalTo: topAnchor),
      
      wheelArrow2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 5),
      wheelArrow2.topAnchor.constraint(equalTo: wheel2.topAnchor, constant: -40),
      
      wheelArrow1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 5),
      wheelArrow1.topAnchor.constraint(equalTo: wheel1.topAnchor, constant: -40),
      
      wheelArrow0.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 5),
      wheelArrow0.topAnchor.constraint(equalTo: wheel0.topAnchor, constant: -40),
      
      mediumButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 90),
      mediumButton.centerYAnchor.constraint(equalTo: wheel2.centerYAnchor),
      
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
