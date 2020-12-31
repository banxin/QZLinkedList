//
//  LinkedListProtocol.swift
//  QZLinkedList
//
//  Created by 山竹 on 2019/12/13.
//  Copyright © 2019 quzhi. All rights reserved.
//

import Foundation

/// 链表协议
protocol LinkedListProtocol {
    /// 关联类型
    associatedtype E: Equatable
    
    /// 描述（快速debug用）
    var description: String { get }
    /// 清除所有元素
    func removeAll()
    /// 元素数量
    func count() -> Int
    /// 是否为空
    func isEmpty() -> Bool
    /// 是否包含某个元素
    /// - Parameter element: 某个元素
    func contains(_ element: E?) -> Bool
    /// 添加元素到最后的位置
    /// - Parameter element: 元素
    func append(_ element: E?)
    /// 添加某个元素到指定位置
    /// - Parameters:
    ///   - index:   指定位置
    ///   - element: 元素
    func insert(_ index: Int, element: E?)
    /// 获取指定位置的元素
    /// - Parameter index: 指定位置
    func get(_ index: Int) -> E?
    /// 设置指定位置的元素
    /// - Parameters:
    ///   - index:   指定位置
    ///   - element: 指定位置上原来的元素
    func set(_ index: Int, element: E?) -> E?
    /// 移除指定位置的元素
    /// - Parameter index: 指定位置
    func remove(_ index: Int) -> E?
    /// 获取某个元素的索引
    /// - Parameter element: 索引
    func indexOf(_ element: E?) -> Int?
}
