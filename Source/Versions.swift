//
//  Versions.swift
//  Versions
//
//  Created by Christoffer Winterkvist on 3/2/15.
//
//

import Foundation

public enum Semantic {
    case Major, Minor, Patch, Same, Unknown
}

public extension String {

    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }

    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }

    var major: String {
        return self[0]
    }

    var minor: String {
        return self[0...2]
    }

    var patch: String {
        return self[0...4]
    }

    func newerThan(version :String) -> Bool {
        return self.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
    }

    func olderThan(version: String) -> Bool {
        let isEqual: Bool = self == version
        return !isEqual ? !self.newerThan(version) : false
    }

    func semanticCompare(version: String) -> Semantic {

        switch self {
        case _ where self == version:
            return .Same
        case _ where self.major != version.major:
            return .Major
        case _ where self[0...2] != version[0...2] && self.olderThan(version):
            return .Minor
        case _ where self[0...4] != version[0...4] && self.olderThan(version):
            return .Patch
        default:
            return .Unknown
        }
    }
}

// This way you can override pattern matching case.
/*func ~=(pattern: String, str: String) -> Bool {
    return str.hasPrefix(pattern)
}*/




