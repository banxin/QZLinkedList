//
//  SingleLinkedList.swift
//  QZLinkedList
//
//  Created by 山竹 on 2019/12/13.
//  Copyright © 2019 quzhi. All rights reserved.
//

import Foundation

/// 单向链表
class SingleLinkedList<E> where E: Equatable {
    /// 元素数量
    private var size: Int = 0
    /// 头节点
    private var first: Node<E>?
    
    /// 内部节点
    private class Node<E> {
        /// 元素
        var element: E?
        /// 下一个元素
        var next: Node<E>?
        
        init(element: E?, next: Node<E>?) {
            self.element = element
            self.next    = next
        }
    }
}

// MARK: - LinkedListProtocol
extension SingleLinkedList: LinkedListProtocol {
    typealias E = E
    
    var description: String {
        var desc = "size -> \(size), ["
        var tempNode = first
        
        (0..<size).forEach {
            if $0 != 0 { desc += ", " }
            
            desc += "\(String(describing: tempNode?.element ?? nil))"
            
            tempNode = tempNode?.next
        }
        
        desc += "]"
        
        return desc
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
        
        // index 为 0 时需特殊处理
        if index == 0 {
            first = Node(element: element, next: first)
        } else {
            let prevNode = node(index - 1)
            prevNode?.next = Node(element: element, next: prevNode?.next)
        }
        
        size += 1
    }
    
    func get(_ index: Int) -> E? {
        node(index)?.element
    }
    
    func set(_ index: Int, element: E?) -> E? {
        let originNode = node(index)
        let originElement = originNode?.element
        originNode?.element = element
        return originElement
    }
    
    func indexOf(_ element: E?) -> Int? {
        var tempNode = first
        
        for i in 0..<size {
            if element == tempNode?.element { return i }
            
            tempNode = tempNode?.next
        }
        
        return nil
    }
    
    func remove(_ index: Int) -> E? {
        LinkedListUtil.indexValidCheck(index, size: size)
        
        var tempNode = first
        
        if index == 0 {
            first = tempNode?.next
        } else {
            let prevNode = node(index - 1)
            
            tempNode = prevNode?.next
            prevNode?.next = tempNode?.next
        }
        
        size -= 1
        
        return tempNode?.element
    }
    
    func removeAll() {
        size  = 0
        first = nil
    }
}

// MARK: - private method
private extension SingleLinkedList {
    /// 获取 index 的 node
    /// - Parameter index: index
    private func node(_ index: Int) -> Node<E>? {
        LinkedListUtil.indexValidCheck(index, size: size)
        
        var node = first
        
        (0..<index).forEach { _ in
            node = node?.next
        }
        
        return node
    }
}
