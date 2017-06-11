import AppKit
import Pilot
import PilotUI

public final class PasteboardStringView: NSView, View, CollectionSupportingView {

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

    // MARK: CollectionViewSupportingView

    public func apply(_ layoutAttributes: NSCollectionViewLayoutAttributes) {}

    // MARK: Private

    private var stringViewModel: PasteboardStringViewModel?

    private let field = Field(labelWithString: "")

    private func loadSubviews() {
        addSubview(field)
        field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            field.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -1),
            field.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            field.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            field.heightAnchor.constraint(equalToConstant: 20)
            ])
        field.drawsBackground = false
        field.isEditable = false
        field.textColor = NSColor.white.withAlphaComponent(0.4)
        field.appearance = NSAppearance(named: .vibrantLight)
        (field.cell as? NSTextFieldCell)?.lineBreakMode = .byTruncatingTail

        let separator = Separator(color: NSColor.white.withAlphaComponent(0.2))
        separator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separator)

        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            separator.rightAnchor.constraint(equalTo: rightAnchor)
            ])
    }
}

private final class Separator: NSView {
    init(color: NSColor) {
        super.init(frame: .zero)
        wantsLayer = true
        layer?.backgroundColor = color.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class Field: NSTextField {
    override var allowsVibrancy: Bool {
        return true
    }
}
