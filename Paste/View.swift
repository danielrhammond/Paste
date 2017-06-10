import AppKit
import Pilot

public final class PasteboardStringView: NSView, View {

    // MARK: Init

    public init() {
        super.init(frame: .zero)
        loadSubviews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSubviews()
    }

    // MARK: View

    public func bindToViewModel(_ viewModel: ViewModel) {
        let stringVM: PasteboardStringViewModel = viewModel.typedViewModel()
        stringViewModel = stringVM
        field.stringValue = stringVM.displayString
    }

    public func unbindFromViewModel() {
        stringViewModel = nil
    }

    public var viewModel: ViewModel? { return stringViewModel }

    // MARK: Private

    private var stringViewModel: PasteboardStringViewModel?

    private let field = NSTextField()

    private func loadSubviews() {
        addSubview(field)
        field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            field.topAnchor.constraint(equalTo: topAnchor),
            field.leftAnchor.constraint(equalTo: leftAnchor),
            field.bottomAnchor.constraint(equalTo: bottomAnchor),
            field.rightAnchor.constraint(equalTo: rightAnchor)
            ])
        field.isEditable = false
    }
}
