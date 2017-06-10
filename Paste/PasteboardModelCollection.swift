import Foundation
import AppKit
import Pilot
import RxSwift

public final class PasteboardModelCollection: SimpleModelCollection {

    init(pasteboard: NSPasteboard = NSPasteboard.general, limit: Int = 5) {
        super.init(collectionId: "pasteboard")
        RxSwift.Observable<Int>.timer(0, period: 1, scheduler: MainScheduler.instance)
            .filter { _ in !pasteboard.shouldSupressCurrentValue() }
            .map { _ -> [Model] in
                let res = pasteboard.readObjects(forClasses: [NSString.self], options: [:])
                return (res ?? [])
                    .flatMap { $0 as? String }
                    .map { PasteboardString(value: $0) }
            }
            .scan([Model]()) { (combined, newModels) -> [Model] in
                var result = combined
                let existing = Set(combined.map({$0.modelId}))
                for new in newModels where !existing.contains(new.modelId) {
                    result.insert(new, at: 0)
                }
                if result.count <= limit {
                    return result
                } else {
                    return Array(result.prefix(upTo: limit))
                }
            }
            .subscribe(onNext: { [weak self] in
                self?.onNext(.loaded($0))
            })
            .disposed(by: disposeBag)
    }

    // MARK: Private
    private let disposeBag = DisposeBag()
}

extension NSPasteboard {

    /// Suppress some types from password managers from showing up in Paste.
    func shouldSupressCurrentValue() -> Bool {
        let availableTypes = Set(types?.map({ $0.rawValue }) ?? [])
        return
            availableTypes.contains("com.agilebits.onepassword") ||
            availableTypes.contains("org.nspasteboard.ConcealedType")
    }
}
