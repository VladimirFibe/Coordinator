import UIKit

final class AppCoordinator: BaseCoordinator {
    override func start() {
        let controller = makeHello()
        router.setRootModule(controller)
    }
}

extension AppCoordinator {
    private func makeHello() -> BaseViewControllerProtocol {
        let useCase = FetchArticlesUseCase(apiService: APIClient.shared)
        let store = HellotStore(fetchArticlesUseCase: useCase)
        let navigation = HelloNavigation(bye: { print("bye - bye")})
        return HelloViewController(navigation: navigation, store: store)
    }
}
