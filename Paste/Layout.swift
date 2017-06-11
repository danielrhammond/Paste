import AppKit

public final class FullWidthLayout: NSCollectionViewLayout {

    // MARK: Public

    public var lineHeight: CGFloat = 38 { didSet { invalidateLayout() } }

    // MARK: NSCollectionViewLayout

    public override func prepare() {
        var newCache = [IndexPath: NSCollectionViewLayoutAttributes]()
        guard let collectionView = collectionView, let dataSource = collectionView.dataSource else { return }
        var current: CGFloat = 0
        for section in 0..<(dataSource.numberOfSections?(in: collectionView) ?? 1) {
            for item in 0..<dataSource.collectionView(collectionView, numberOfItemsInSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = NSCollectionViewLayoutAttributes(forItemWith: indexPath)
                attributes.frame = NSRect(x: 0, y: current, width: collectionView.bounds.width, height: lineHeight)
                newCache[indexPath] = attributes
                current += lineHeight
            }
        }
        lastWidth = collectionView.bounds.width
        contentSize = NSSize(width: collectionView.bounds.width, height: current)
        cache = newCache
    }

    public override func layoutAttributesForElements(in rect: NSRect) -> [NSCollectionViewLayoutAttributes] {
        let attributes = cache.values.filter { $0.frame.intersects(rect) }
        return attributes
    }

    public override func layoutAttributesForItem(at indexPath: IndexPath) -> NSCollectionViewLayoutAttributes? {
        return cache[indexPath]
    }

    public override func shouldInvalidateLayout(forBoundsChange newBounds: NSRect) -> Bool {
        // FIXME: float equality check
        return newBounds.width != lastWidth
    }

    public override var collectionViewContentSize: NSSize {
        return contentSize ?? .zero
    }

    // MARK: Private

    private var cache = [IndexPath: NSCollectionViewLayoutAttributes]()
    private var lastWidth: CGFloat?
    private var contentSize: NSSize?
}
