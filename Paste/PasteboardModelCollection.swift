import Foundation
import AppKit
import Pilot
import RxSwift

public final class PasteboardModelCollection: SimpleModelCollection {

    init() {
        super.init(collectionId: "pasteboard")
        RxSwift.Observable<Int>.timer(0, period: 5, scheduler: MainScheduler.instance)
            .map { _ -> [String] in
                let res = NSPasteboard.general().readObjects(forClasses: [NSString.self], options: [:])
                return (res ?? []).flatMap { $0 as? String }
            }
            .subscribe(onNext: {
                Swift.print("Next: \($0)")
            })
            .disposed(by: disposeBag)
    }

    // MARK: Private
    private let disposeBag = DisposeBag()
}
