import Combine

class LoadingViewModel: ObservableObject {
    @Published var isLoading: Bool = true { didSet { print(isLoading, "Loading")}}
}
