//
//  Array+Extensions.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/4.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import Foundation

public extension RandomAccessCollection {
    
    // ToDo
    func element(at index: Int) -> Element? {
        return nil
    }
}

extension Array {
    
    fileprivate var range: Range<Int> {
        return startIndex..<endIndex
    }
    
    public func object(at index: Int) -> Element? {
        guard range.contains(index) else {
            return nil
        }
        return self[index]
    }
}
