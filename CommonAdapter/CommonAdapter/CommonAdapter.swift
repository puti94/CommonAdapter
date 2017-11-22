//
//  TableAdapter.swift
//  封装类似Android的万能适配器
//
//  Created by puti on 2017/10/7.
//  Copyright © 2017年 puti. All rights reserved.
//

import Foundation
import UIKit
class CommonAdapter<M, T:UIView, V:AdapterProtocol>: NSObject where T: NibReusable, V: UIView {
    //数据源
    var datas: [M] = []
    weak var view: V!
    //单个表单点击的闭包
    var itemClick: ((Int, M) -> Void)? = nil
    //单个表单点击的闭包
    var itemChildClick: ((Int, Int, M) -> Void)? = nil
    var mConvert: ((T, M, Int) -> Void)? = nil

    public override init() {

    }

    /// 设置新的数据源
    ///
    /// - Parameter datas: 数据源
    func setNewDatas(_ datas: [M]) {
        self.datas = datas
        view.aReloadData()
    }

    /// 追加新的数据
    ///
    /// - Parameter datas: <#datas description#>
    func addNewDatas(_ datas: [M]) {
        self.datas.append(contentsOf: datas)
        view.aReloadData()
    }

    /// 继承此类可重载此方法
    ///
    /// - Parameters:
    ///   - cell: cell实例
    ///   - item: <#item description#>
    public func convert(cell: T, item: M) {


    }

    /// 继承此类可重载此方法
    ///
    /// - Parameters:
    ///   - cell: cell实例
    ///   - item: <#item description#>
    public func convert(cell: T, item: M, position: Int) {


    }


    /// 设置Cell的布局,UITableView的cellForRowAt回调时触发此方法
    ///
    /// - Parameters:
    ///   - cell: UITableViewCell实例
    ///   - data: 数据
    final func setCellView(_ cell: T, _ data: M, _ position: Int) {
        if mConvert != nil {
            mConvert!(cell, data, position)
        }
        convert(cell: cell, item: data)
        convert(cell: cell, item: data, position: position)
    }
}

