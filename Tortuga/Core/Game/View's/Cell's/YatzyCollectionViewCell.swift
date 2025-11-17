import UIKit

class YatzyCollectionViewCell: UICollectionViewCell {
  static let id = "list"
  
  public let name: UILabel = {
    let label = UILabel()
    label.text = "Combo Name"
    label.font = UIFont(name: "Papyrus", size: 8)
    label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  public let playerCheck: UIImageView = {
    let image = UIImage(named: "Check0")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let player: UILabel = {
    let label = UILabel()
    label.text = "0"
    label.font = UIFont(name: "Papyrus", size: 8)
    label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  public let enemyCheck: UIImageView = {
    let image = UIImage(named: "Check0")
    let imageView = UIImageView(image: image)
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  public let enemy: UILabel = {
    let label = UILabel()
    label.text = "0"
    label.font = UIFont(name: "Papyrus", size: 8)
    label.textColor = #colorLiteral(red: 0.1725490196, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    label.textAlignment = .center
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
    addSubview(contentView)
    contentView.addSubview(name)
    contentView.addSubview(playerCheck)
    contentView.addSubview(player)
    contentView.addSubview(enemyCheck)
    contentView.addSubview(enemy)
    
    let constraints = [
      name.centerYAnchor.constraint(equalTo: centerYAnchor),
      name.leftAnchor.constraint(equalTo: leftAnchor, constant: 50),
      
      playerCheck.centerYAnchor.constraint(equalTo: player.centerYAnchor),
      playerCheck.centerXAnchor.constraint(equalTo: player.centerXAnchor),
      
      player.centerYAnchor.constraint(equalTo: centerYAnchor),
      player.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 45),
      
      enemyCheck.centerYAnchor.constraint(equalTo: enemy.centerYAnchor),
      enemyCheck.centerXAnchor.constraint(equalTo: enemy.centerXAnchor),
      
      enemy.centerYAnchor.constraint(equalTo: centerYAnchor),
      enemy.centerXAnchor.constraint(equalTo: rightAnchor, constant: -50)
    ]
    NSLayoutConstraint.activate(constraints)
  }
}
