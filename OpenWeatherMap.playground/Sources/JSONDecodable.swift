import Foundation

protocol JSONDecodable {
    init(decoder: JSONDecoder) throws
}

public enum JSONDecoderError: Error {
    case invalidData
    case keyNotFound(String)
    case keyPathNotFound(String)
}

public struct JSONDecoder {
    typealias JSON = [String: AnyObject]
    private let JSONData : JSON
    
    public init(data: Data) throws {
        if let JSONData = try JSONSerialization.jsonObject(with: data, options: []) as? JSON {
            self.JSONData = JSONData
        } else {
            throw JSONDecoderError.invalidData
        }
    }

    private init(JSONData: JSON) throws {
        self.JSONData = JSONData
    }

    func decode<T>(key: String) throws -> T {
        if key.contains(".") {
            return try value(forKeyPath: key)
        }
        guard let value: T = try? value(forKey: key) else { throw JSONDecoderError.keyNotFound(key) }
        return value
    }

    func decode<T: JSONDecodable>(key: String) throws -> [T] {
        if key.contains(".") {
            return try value(forKeyPath: key)
        }
        guard let value: [T] = try? value(forKey: key) else { throw JSONDecoderError.keyNotFound(key) }
        return value
    }

    private func value<T>(forKey key: String) throws -> T {
        guard let value = JSONData[key] as? T else { throw JSONDecoderError.keyNotFound(key) }
        return value
    }

    private func value<T: JSONDecodable>(forKey key: String) throws -> [T] {
        if let value = JSONData[key] as? [JSON] {
            return try value.map({ (partial) -> T in
                let decoder =  try JSONDecoder(JSONData: partial)
                return try T(decoder: decoder)
            })
        }
        throw JSONDecoderError.keyNotFound(key)
    }

    private func value<T>(forKeyPath keyPath: String) throws -> T {
        var partial = JSONData
        let keys = keyPath.components(separatedBy: ".")

        for i in 0..<keys.count {
            if i < keys.count - 1 {
                if let partialJSONData = JSONData[keys[i]] as? JSON {
                    partial = partialJSONData
                } else {
                    throw JSONDecoderError.invalidData
                }
            } else {
                return try JSONDecoder(JSONData: partial).value(forKey: keys[i])
            }
        }
        throw JSONDecoderError.keyPathNotFound(keyPath)
    }

    private func value<T: JSONDecodable>(forKeyPath keyPath: String) throws -> [T] {
        var partial = JSONData
        let keys = keyPath.components(separatedBy: ".")

        for i in 0..<keys.count {
            if i < keys.count - 1 {
                if let partialJSONData = JSONData[keys[i]] as? JSON {
                    partial = partialJSONData
                } else {
                    throw JSONDecoderError.invalidData
                }
            } else {
                return try JSONDecoder(JSONData: partial).value(forKey: keys[i])
            }
        }
        throw JSONDecoderError.keyPathNotFound(keyPath)
    }

}
