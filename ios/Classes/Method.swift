//
//  Method.swift
//  bluetooth_plugin
//
//  Created by Ali Almasli on 21.06.22.
//

enum Method {
    case none
    case scan
}

extension String {
    var cased: Method {
        switch self {
        case "scan": return .scan
        default:
            return .none
        }
    }
}
