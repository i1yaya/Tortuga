import UIKit

class SplashView: UIView {
  public let background: UIImageView = {
    let image = UIImage(named: "Launch")
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let circle: UIImageView = {
    let image = UIImage(named: "Circle")
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
    addSubview(circle)
    
    let constraints = [
      background.rightAnchor.constraint(equalTo: rightAnchor),
      background.leftAnchor.constraint(equalTo: leftAnchor),
      background.topAnchor.constraint(equalTo: topAnchor),
      background.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      circle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
      circle.centerXAnchor.constraint(equalTo: centerXAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
  }
}
