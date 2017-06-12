import AppKit
import Pilot
import PilotUI

public final class PasteboardViewController: CollectionViewController {

    public init(context: Context) {
        let model = PasteboardModelCollection()
        let layout = FullWidthLayout()
        super.init(
            model: model,
            modelBinder: DefaultViewModelBindingProvider(),
            viewBinder: StaticViewBindingProvider(type: PasteboardStringView.self),
            layout: layout,
            context: context)
        backgroundColor = .clear
    }

    public override func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        super.collectionView(collectionView, didSelectItemsAt: indexPaths)
        collectionView.deselectItems(at: indexPaths)
    }
}
