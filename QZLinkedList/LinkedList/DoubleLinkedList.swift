//
//  DoubleLinkedList.swift
//  QZLinkedList
//
//  Created by 山竹 on 2019/12/17.
//  Copyright © 2019 quzhi. All rights reserved.
//

import Foundation

/// 双向链表
public class DoubleLinkedList<E> where E: Equatable {
    /// 元素数量
    private var size: Int = 0
    /// 首个元素
    private var first: Node<E>?
    /// 最后一个元素
    private var last: Node<E>?
    
    /// 内部节点
    private class Node<E> {
        /// 上一个元素
        weak var prev: Node<E>?
        /// 元素
        var element: E?
        /// 下一个元素
        var next: Node<E>?
        
        /// 简述(debug 用)
        var description: String {
            var desc = ""
            
            desc += "\(String(describing: prev?.element ?? nil))"
            desc += "_\(String(describing: element ?? nil))_"
            desc += "\(String(describing: next?.element ?? nil))"
            
            return desc
        }
        
        init(prev: Node<E>?, element: E?, next: Node<E>?) {
            self.prev    = prev
            self.element = element
            self.next    = next
        }
    }
}

// MARK: - LinkedListProtocol
extension DoubleLinkedList: LinkedListProtocol {
    typealias E = E
    
    var description: String {
        var desc = "size -> \(size), ["
        
        var tempNode = first

        (0..<size).forEach {
            if $0 != 0 { desc += ", " }

            desc += tempNode?.description ?? ""

            tempNode = tempNode?.next
        }

        desc += "]"

        return desc
    }
    
    func removeAll() {
        size  = 0
        first = nil
        last  = nil
    }
    
    func count() -> Int {
        size
    }
    
    func isEmpty() -> Bool {
        size == 0
    }
    
    func contains(_ element: E?) -> Bool {
        if let _ = indexOf(element) {
            return true
        }
        return false
    }
    
    func append(_ element: E?) {
        insert(size, element: element)
    }
    
    func insert(_ index: Int, element: E?) {
        LinkedListUtil.indexValidCheckForAdd(index, size: size)
        
        // 当往最后添加时
        if index == size {
            let oldLast = last
            last = Node(prev: oldLast, element: element, next: nil)
            
            if let _ = oldLast {
                oldLast?.next = last
            } else {
                first = last
            }
        } else { // 其他场景
            let next = node(index)
            let prev = next?.prev
            let current = Node(prev: prev, element: element, next: next)
            next?.prev = current
            
            // 当index 为 0时
            if let _ = prev {
                prev?.next = current
            } else {
                first = current
            }
        }
        
        size += 1
    }
    
    func get(_ index: Int) -> E? {
        node(index)?.element
    }
    
    func set(_ index: Int, element: E?) -> E? {
        let currentNode = node(index)
        let oldElemet = currentNode?.element
        currentNode?.element = element
        
        return oldElemet
    }
    
    func remove(_ index: Int) -> E? {
        LinkedListUtil.indexValidCheck(index, size: size)
        
        let current = node(index)
        let prev = current?.prev
        let next = current?.next
        
        // inde为0时
        if let _ = prev {
            prev?.next = next
        } else {
            first = next
        }
        
        // index为size - 1时
        if let _ = next {
            next?.prev = prev
        } else {
            last = prev
        }
        
        size -= 1
        return current?.element
    }
    
    func indexOf(_ element: E?) -> Int? {
        var tempNode = first
        for i in 0..<size {
            if element == tempNode?.element { return i }
            
            tempNode = tempNode?.next
        }
        
        return nil
    }
}

// MARK: - private method
private extension DoubleLinkedList {
    /// 获取 index 的 node
    /// - Parameter index: index
    private func node(_ index: Int) -> Node<E>? {
        LinkedListUtil.indexValidCheck(index, size: size)
        
        // 使用二分法提升效率
        if (index < (size >> 1)) {
            var node = first
            
            (0..<index).forEach { _ in
                node = node?.next
            }
            
            return node
        } else {
            var node = last
            
            (index..<size - 1).forEach { _ in
                node = node?.prev
            }
            
            return node
        }
    }
}
