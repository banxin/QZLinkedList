## Swift 链表

### 一、概念

**什么是链表：**

* 1. 链表和数组类似，也是一种线性表结构
* 2. 链表是一种物理存储单元上非连续、非顺序的存储结构，数据元素的逻辑顺序是通过链表中的指针链接次序实现的
* 3. 链表由一系列节点组成，每个节点一般至少会包含两部分信息：一部分是元素数据本身，另一部分是指向下一个元素地址的指针

**链表的特点：**

* 1. 链表克服了数组需要提前设置长度的缺点，在运行时可以根据需要随意添加元素
* 2. 计算机的存储空间并不总是连续可用的，而链表可以灵活地使用存储空间，还能更好地对内存进行动态管理
* 3. 插入、删除数据效率高，只需要考虑相邻结点的指针改变，不需要搬移数据，时间复杂度是 O(1)
* 4. 随机查找效率低，需要根据指针一个结点一个结点的遍历查找，时间复杂度为O(n)
* 5. 与内存相比，链表的空间消耗大，因为每个结点除了要存储数据本身，还要储存上(下)结点的地址

**链表的类型：**

链表分为两种类型：单向链表和双向链表。我们平时说道的链表指的是单向链表。当然，除了这些普通的链表，链表由于其特点还衍生了很多特殊的情况，例如单向循环链表、双向循环链表。

`Swift`原生是没有链表的，本文使用`Swift`分析和设计单向链表和双向链表。

### 二、Swift链表的设计

由于链表和数组类似，所以设计时考虑如下几点：

* 1. 使用与数组类似的API，方便调用
* 2. 使用泛型，支持更多的数据类型，由于需要做是否等于的比较，所有泛型需遵循`Equatable`协议
* 3. 链表调试不易，所以使用了一个`description`属性快速调试用

定义一个链表`protocal`，单向和双向都遵循该协议：

```Swift
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
```

### 三、单向链表

**单向链表的结构如下图：**

![单向链表.png](https://upload-images.jianshu.io/upload_images/3373160-88a0445ea267a07d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**具体实现如下：**

```Swift
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
```

**注意点：**不论添加还是删除，首尾节点的操作需要特殊处理

### 四、双向链表

**双向链表的结构如下图：**

![双向链表.png](https://upload-images.jianshu.io/upload_images/3373160-346f2b905bceac86.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**具体实现如下：**

```Swift
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
```

**注意点：**

* 1.双向链表中节点的设计，需要将上一个或下一个节点设置为`weak`，来避免循环引用

    > 例如现在在一个链表中，节点B在节点A后面，这样A是指向B的。假如现在节点B也指向节点A，这就导致A和B互相强引用。在某些情况下,这种所有权循环（ownership cycle）会使得即使你删除它们，节点依然存活着（也就是所谓的内存泄露）。所以我们需要将其中一个指针设置为weak，用来打破这种循环。

* 2.不论添加还是删除，首尾节点的操作需要特殊处理
    
### 五、链表的使用

**经典的链表应用场景： LRU 缓存淘汰算法**

缓存是一种提高数据读取性能的技术，在硬件设计、软件开发中都有着非常广泛的应用，比如常见的CPU缓存、数据库缓存、浏览器缓存等等。

缓存空间的大小有限，当缓存空间被用满时，哪些数据应该被清理出去，哪些数据应该被保留？这就需要缓存淘汰策略来决定。

######常见的缓存清理策略有三种：

* 先进先出策略FIFO（First In, First Out）
* 最少使用策略 LFU（Least Frequently Used）
* 最近最少使用策略LRU（Least Recently Used）

######如何用链表来实现LRU缓存淘汰策略呢？

**思路：**维护一个有序单链表，越靠近链表尾部的结点是越早之前访问的。当有一个新的数据被访问时，我们从链表头部开始顺序遍历链表。

1. 如果此数据之前已经被缓存在链表中了，我们遍历得到这个数据的对应结点，并将其从原来的位置删除，并插入到链表头部
2. 如果此数据没在缓存链表中，又可以分为两种情况处理

如果此时缓存未满，可直接在链表头部插入新节点存储此数据，
如果此时缓存已满，则删除链表尾部节点，再在链表头部插入新节点。

**`YYCache`中的缓存策略使用的淘汰算法即是，`LRU`缓存淘汰算法**

设计该链表也是为了后续使用`YYCache`的思路写一个`Swift`版本的缓存库。

### 六、后记

[源码地址](https://github.com/banxin/QZLinkedList)

* **思考：**

1. 单向链表提升性能和统一操作的方式，加一个虚拟节点怎么实现
2. 单向循环列表的实现
3. 双向循环列表的实现
4. 双向循环链表提升性能，加一个当前节点怎么实现

* **链表的一些练习题：**

1. 如何反转一个单向链表，可以有哪些方式实现

    > 思路：递归和循环的方式均可实现

2. 判断一个链表中是否有环

    > 使用快慢指针即可


--

**参考文档：**

<http://www.chinacion.cn/article/4419.html>
<https://blog.csdn.net/actionabll/article/details/100764473>

