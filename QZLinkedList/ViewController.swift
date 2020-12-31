//
//  ViewController.swift
//  QZLinkedList
//
//  Created by 山竹 on 2019/12/13.
//  Copyright © 2019 quzhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        testSingleLinkedList()
//        testDoubleLinkedList()
    }
}

// MARK: - UI
private extension ViewController {
    func setupUI() {
        title = "链表"
    }
}

// MARK: - 链表测试
private extension ViewController {
    /// 测试单向链表
    func testSingleLinkedList() {
        let list = SingleLinkedList<Int>()
        
        list.append(11)
        list.append(22)
        list.append(33)
        list.append(44)

        list.insert(0, element: 55); // [55, 11, 22, 33, 44]
        list.insert(2, element: 66); // [55, 11, 66, 22, 33, 44]
        list.insert(list.count(), element: 77); // [55, 11, 66, 22, 33, 44, 77]

        _ = list.remove(0) // [11, 66, 22, 33, 44, 77]
        _ = list.remove(2) // [11, 66, 33, 44, 77]
        _ = list.remove(list.count() - 1) // [11, 66, 33, 44]

        assert(list.indexOf(44) == 3)
        assert(list.indexOf(22) == nil)
        assert(list.contains(33))
        assert(list.get(0) == 11)
        assert(list.get(1) == 66)
        assert(list.get(list.count() - 1) == 44)
        
        print(list.description)
    }
    
    /// 测试双向链表
    func testDoubleLinkedList() {
        let list = DoubleLinkedList<Int>()
        
        list.append(11)
        list.append(22)
        list.append(33)
        list.append(44)

        list.insert(0, element: 55); // [55, 11, 22, 33, 44]
        list.insert(2, element: 66); // [55, 11, 66, 22, 33, 44]
        list.insert(list.count(), element: 77); // [55, 11, 66, 22, 33, 44, 77]

        _ = list.remove(0) // [11, 66, 22, 33, 44, 77]
        _ = list.remove(2) // [11, 66, 33, 44, 77]
        _ = list.remove(list.count() - 1) // [11, 66, 33, 44]

        assert(list.indexOf(44) == 3)
        assert(list.indexOf(22) == nil)
        assert(list.contains(33))
        assert(list.get(0) == 11)
        assert(list.get(1) == 66)
        assert(list.get(list.count() - 1) == 44)
        
        print(list.description)
    }
}
