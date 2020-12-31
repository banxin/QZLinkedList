//
//  LinkedListUtil.swift
//  QZLinkedList
//
//  Created by 山竹 on 2019/12/18.
//  Copyright © 2019 quzhi. All rights reserved.
//

import Foundation

/// 链表 util
struct LinkedListUtil {
    /// 越界
    /// - Parameter index: index
    /// - Parameter size:  链表元素数量
    static func outOfBounds(_ index: Int, size: Int) {
        assert(false, "越界了：index --> \(index), size --> \(size)")
    }
    
    /// check index 的有效性
    /// - Parameter index: index
    /// - Parameter size:  链表元素数量
    static func indexValidCheck(_ index: Int, size: Int) {
        if index < 0 || index >= size {
            LinkedListUtil.outOfBounds(index, size: size)
        }
    }
    
    /// check ad index 的有效性
    /// - Parameter index: index
    /// - Parameter size:  链表元素数量
    static func indexValidCheckForAdd(_ index: Int, size: Int) {
        if index < 0 || index > size {
            LinkedListUtil.outOfBounds(index, size: size)
        }
    }
}
