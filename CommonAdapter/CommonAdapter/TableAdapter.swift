//
//  TableAdapter.swift
//  封装类似Android的万能适配器
//
//  Created by puti on 2017/10/7.
//  Copyright © 2017年 puti. All rights reserved.
//

import Foundation
import UIKit

class TableAdapter<M, T:XTableViewCell>: CommonAdapter<M, T, UITableView>, UITableViewDelegate, UITableViewDataSource {


    var cellForPosition: ((UITableView, M, Int) -> UITableViewCell)? = nil
    /// TableAdapter 构造方法 用于初始化一些UITableView的设置
    ///
    /// - Parameters:
    ///   - tableView: 传入UITableView的实例
    ///   - datas: UITableView的数据源
    ///   - estimatedRowHeight:预设高度
    ///   - convert: 设置Cell布局的闭包
    required init(_ tableView: UITableView, datas: [M]? = nil, estimatedRowHeight: CGFloat = 60, convert: ((T, M, Int) -> Void)? = nil) {
        super.init()
        self.view = tableView
        if datas != nil {
            self.datas = datas!
        }
        self.view.dataSource = self
        self.view.delegate = self
        self.view.register(cellType: T.self)
        self.view.tableFooterView = UIView()
        //去掉分割线
        self.view.separatorStyle = .none
        self.mConvert = convert
        self.view.estimatedRowHeight = estimatedRowHeight
        self.view.rowHeight = UITableViewAutomaticDimension
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection",datas.count)
        return datas.count
    }

    /// 实现UITable的协议
    ///
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#return value description#>
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt",indexPath)

        //拦截处理，用于实现多布局
        if cellForPosition != nil {
            return cellForPosition!(tableView, datas[indexPath.row], indexPath.row)
        }
        let cell: T = tableView.dequeueReusableCell(for: indexPath)
        setCellView(cell, datas[indexPath.row], indexPath.row)
        cell.click = { tag in
            if self.itemChildClick != nil {
                self.itemChildClick!(tag, indexPath.row, self.datas[indexPath.row])
            }
        }
        return cell
    }



    /// 实现点击协议
    ///
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.deselectRow(at: indexPath, animated: true)
        if itemClick != nil {
            itemClick!(indexPath.row, datas[indexPath.row])
        }
    }
}
