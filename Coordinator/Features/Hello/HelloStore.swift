import Combine

enum HelloEvent {
    case ready([String])
}

enum HelloAction {
    case fetch
}

final class HellotStore: Store<HelloEvent, HelloAction> {
    private let fetchArticlesUseCase: FetchArticlesUseCaseProtocol

    init(fetchArticlesUseCase: FetchArticlesUseCaseProtocol) {
        self.fetchArticlesUseCase = fetchArticlesUseCase
    }

    override func handleActions(action: HelloAction) {
        switch action {
        case .fetch:
            statefulCall(fetchArticles)
        }
    }

    private func fetchArticles() async throws {
        let articles = try await fetchArticlesUseCase.execute()
        sendEvent(.ready(articles))
    }
}

protocol FetchArticlesUseCaseProtocol {
    func execute() async throws -> [String]
}

final class FetchArticlesUseCase: FetchArticlesUseCaseProtocol {
    private let apiService: ArticleListServiceProtocol

    init(apiService: ArticleListServiceProtocol) {
        self.apiService = apiService
    }

    func execute() async throws -> [String] {
        try await apiService.fetchArticles()
    }
}

protocol ArticleListServiceProtocol {
    func fetchArticles() async throws -> [String]
}

final class APIClient {
    static let shared = APIClient()
    private init(){}
}

extension APIClient: ArticleListServiceProtocol {
    func fetchArticles() async throws -> [String] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return ["One", "Two", "Three"]
    }
}
