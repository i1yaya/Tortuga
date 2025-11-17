import UIKit

class SplashViewController: UIViewController {
  private var splashView: SplashView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupController()
    
    setupView()
    
    animateLoading()
  }
  
  private func setupController() {
    view.backgroundColor = .black
    navigationItem.hidesBackButton = true
  }
  
  private func setupView() {
    splashView = SplashView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    splashView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(splashView)
    
    let constraints = [
      splashView.leftAnchor.constraint(equalTo: view.leftAnchor),
      splashView.rightAnchor.constraint(equalTo: view.rightAnchor),
      splashView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      splashView.topAnchor.constraint(equalTo: view.topAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
  }
  
  private func animateLoading() {
    UIView.animate(withDuration: 5, delay: 0, options: .curveLinear){
      self.splashView.circle.transform = self.splashView.circle.transform.rotated(by: .pi)
    } completion: { _ in
      UIView.animate(withDuration: 5, delay: 0, options: .curveLinear){
        self.splashView.circle.transform = self.splashView.circle.transform.rotated(by: .pi)
      } completion: { _ in
        UIView.animate(withDuration: 5, delay: 0, options: .curveEaseOut) {
          self.splashView.circle.transform = CGAffineTransform(
            rotationAngle: .pi * 2)
        }
      }
    }
  }
}
