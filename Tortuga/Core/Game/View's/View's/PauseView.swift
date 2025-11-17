import UIKit

class PauseView: UIView {
  public let background: UIImageView = {
    let image = UIImage(named: "PauseBackground")
    let imageView = UIImageView(image: image)
    imageView.alpha = 0.75
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let resumeButton: UIButton = {
    let image = UIImage(named: "PauseResume")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let replayButton: UIButton = {
    let image = UIImage(named: "PauseReplay")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let menuButton: UIButton = {
    let image = UIImage(named: "MenuButton")
    let button = UIButton()
    button.setBackgroundImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  public let label: UIImageView = {
    let image = UIImage(named: "PauseLabel")
    let imageView = UIImageView(image: image)
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
    addSubview(label)
    addSubview(menuButton)
    addSubview(replayButton)
    addSubview(resumeButton)
    
    let constraints = [
      background.rightAnchor.constraint(equalTo: rightAnchor),
      background.leftAnchor.constraint(equalTo: leftAnchor),
      background.topAnchor.constraint(equalTo: topAnchor),
      background.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      label.topAnchor.constraint(equalTo: topAnchor),
      label.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      menuButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      menuButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      replayButton.leftAnchor.constraint(equalTo: centerXAnchor, constant: 10),
      replayButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      resumeButton.rightAnchor.constraint(equalTo: centerXAnchor, constant: -10),
      resumeButton.centerYAnchor.constraint(equalTo: centerYAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
  }
}

