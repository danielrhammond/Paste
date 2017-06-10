import AppKit
import Pilot
import PilotUI

public final class PasteboardViewController: CollectionViewController {

    public init(context: Context) {
        let model = PasteboardModelCollection()
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSSize(width: 320, height: 24)
        super.init(
            model: model,
            modelBinder: DefaultViewModelBindingProvider(),
            viewBinder: StaticViewBindingProvider(type: PasteboardStringView.self),
            layout: layout,
            context: context)
    }
}
