import Cocoa
import Pilot
import RxSwift
import RxCocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        loadUI()
        setupActionHandlers()
    }

    // MARK: NSApplicationDelegate

    @IBOutlet weak var window: NSWindow!

    // MARK: Private

    private let context = Context()
    private var rootViewController: NSViewController?
    private var contextObserver: Pilot.Observer?

    private func loadUI() {
        let viewController = PasteboardViewController(context: context)
        guard let windowView = window.contentView as? NSVisualEffectView else { return }
        window.appearance = NSAppearance(named: .vibrantDark)
        windowView.blendingMode = .behindWindow
        windowView.material = .dark
        windowView.isEmphasized = true
        windowView.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: windowView.topAnchor),
            viewController.view.leftAnchor.constraint(equalTo: windowView.leftAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: windowView.bottomAnchor),
            viewController.view.rightAnchor.constraint(equalTo: windowView.rightAnchor)
            ])
        rootViewController = viewController
    }

    private func setupActionHandlers() {
        contextObserver = context.receive { (action: PasteboardCopyAction) -> ActionResult in
            NSPasteboard.general.clearContents()
            switch action.value {
            case .string(let value):
                NSPasteboard.general.writeObjects([value as NSString])
            }
            return .handled
        }
    }
}
