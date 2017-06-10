import Pilot

public struct PasteboardString: Model {
    public init(value: String) {
        self.value = value
        self.modelId = String(value.hash)
    }

    // MARK: Public

    public let value: String

    // MARK: Model

    public let modelId: ModelId

    public var modelVersion: ModelVersion {
        var mixer = ModelVersionMixer()
        mixer.mix(value)
        return mixer.result()
    }
}

extension PasteboardString: Equatable {}

public func == (lhs: PasteboardString, rhs: PasteboardString) -> Bool {
    return lhs.value == rhs.value
}

extension PasteboardString: Hashable {
    public var hashValue: Int {
        return value.hashValue
    }
}
