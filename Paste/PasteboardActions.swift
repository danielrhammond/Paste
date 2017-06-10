import Pilot

public enum PasteboardValue {
    case string(String)
}

public struct PasteboardCopyAction: Action {
    public var value: PasteboardValue
}
