import UIKit

final class AppCoordinator: BaseCoordinator {
    override func start() {
        let controller = ViewController()
        router.setRootModule(controller)
    }

    private func runTabbar() {
//        let coordinator = TabBarCoordinator(router: router)
//        addDependency(coordinator)
//        coordinator.start()

        
    }
}
