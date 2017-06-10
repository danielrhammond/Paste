import Pilot

public struct PasteboardStringViewModel: ViewModel {
    public init(model: Model, context: Context) {
        self.pasteboardString = model.typedModel()
        self.context = context
    }

    // MARK: Public

    public var displayString: String { return pasteboardString.value }

    // MARK: ViewModel

    public let context: Context

    // MARK: Prviate

    private let pasteboardString: PasteboardString
}

extension PasteboardString: ViewModelConvertible {
    public func viewModelWithContext(_ context: Context) -> ViewModel {
        return PasteboardStringViewModel(model: self, context: context)
    }
}
