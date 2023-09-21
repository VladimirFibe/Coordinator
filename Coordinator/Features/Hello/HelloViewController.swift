import SwiftUI

struct HelloNavigation {
    let bye: Callback
}
class HelloViewController: BaseViewController {
    private let navigation: HelloNavigation
    private let store: HellotStore
    private let viewModel = HelloViewModel()
    private var bag = Bag()
    
    init(navigation: HelloNavigation, store: HellotStore) {
        self.navigation = navigation
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }

    private lazy var rootView: BridgedView = {
        Text("Coordinator").bridge()
    }()

    private func setupObservers() {
        bindLoading(to: view, from: store).store(in: &bag)
        bindError(to: view, from: store).store(in: &bag)

        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .ready(_):
                    self.view.backgroundColor = .green
                }
            }.store(in: &bag)
    }
}

extension HelloViewController {
    override func setupViews() {
        view.backgroundColor = .systemBackground
        addBridgedViewAsRoot(rootView)
        setupObservers()
        store.sendAction(.fetch)
    }
}

