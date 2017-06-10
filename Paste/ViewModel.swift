import Pilot

public struct PasteboardStringViewModel: ViewModel {
    public init(model: Model, context: Context) {
        self.pasteboardString = model.typedModel()
        self.context = context
    }

    // MARK: Public

    public var displayString: String {
        return pasteboardString.value.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // MARK: ViewModel

    public let context: Context

    public func handleUserEvent(_ event: ViewModelUserEvent) {
        switch event {
        case .click, .enterKey:
            PasteboardCopyAction(value: .string(pasteboardString.value)).send(from: context)
        default:
            break
        }
    }

    // MARK: Prviate

    private let pasteboardString: PasteboardString
}

extension PasteboardString: ViewModelConvertible {
    public func viewModelWithContext(_ context: Context) -> ViewModel {
        return PasteboardStringViewModel(model: self, context: context)
    }
}
