import SwiftUI

class ViewController: BaseViewController {
    private lazy var rootView: BridgedView = {
        Text("Coordinator").bridge()
    }()
}

extension ViewController {
    override func setupViews() {
        view.backgroundColor = .green
        addBridgedViewAsRoot(rootView)
    }
}

