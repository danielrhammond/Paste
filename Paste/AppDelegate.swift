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
    private lazy var contentViewController: PasteboardViewController = {
        PasteboardViewController(context: self.context)
    }()
    private var contextObserver: Pilot.Observer?
    private var item: NSStatusItem?
    private weak var popover: NSPopover?

    @objc
    private func buttonAction() {
        guard self.popover == nil else {
            self.popover?.close()
            self.popover = nil
            return
        }
        let popover = NSPopover()
        popover.behavior = .transient
        popover.contentViewController = contentViewController
        popover.contentSize = NSSize(width: 400, height: 190)
        if let view = item?.button {
            popover.show(relativeTo: view.bounds, of: view, preferredEdge: .maxY)
        }
        self.popover = popover
    }

    private func loadUI() {
        let image = #imageLiteral(resourceName: "pasteboard")
        image.isTemplate = true

        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        item.button?.image = image
        item.target = self
        item.action = #selector(buttonAction)
        self.item = item
    }

    private func setupActionHandlers() {
        contextObserver = context.receive { (action: PasteboardCopyAction) -> ActionResult in
            NSPasteboard.general.clearContents()
            switch action.value {
            case .string(let value):
                NSPasteboard.general.writeObjects([value as NSString])
            }
            self.popover?.close()
            return .handled
        }
    }
}
