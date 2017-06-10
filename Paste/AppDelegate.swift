import Cocoa
import Pilot
import RxSwift
import RxCocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let viewController = PasteboardViewController(context: context)
        guard let windowView = window.contentView else { return }
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

    // MARK: NSApplicationDelegate

    @IBOutlet weak var window: NSWindow!

    // MARK: Private

    private let context = Context()
    private var rootViewController: NSViewController?
}
