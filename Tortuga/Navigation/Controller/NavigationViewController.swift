import UIKit

final class NavigationViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
    
    MusicPlayer.shared.backgroundMusic()
    
    tabBar.isHidden = true
  }
  
  private func setupTabBar() {
    let menuViewController = createNavigationController(viewController: MainViewController(), itemName: "", itemImage: "", boolLarge: true)
    
    viewControllers = [menuViewController]
  }
  
  private func createNavigationController(viewController: UIViewController, itemName: String, itemImage: String, boolLarge: Bool) -> UINavigationController {
    let item = UITabBarItem(title: itemName, image: UIImage(named: "\(itemImage)"), tag: 0)
    item.titlePositionAdjustment = .init(horizontal: 0, vertical: 1)
    
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.tabBarItem = item
    navigationController.navigationBar.prefersLargeTitles = boolLarge
    navigationController.navigationBar.tintColor = .white
    navigationController.navigationBar.barTintColor = .white
    
    return navigationController
  }
}
