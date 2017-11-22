//
//  AdapterExtension.swift
//  Test
//
//  Created by puti on 2017/10/7.
//  Copyright © 2017年 puti. All rights reserved.
//

import UIKit
extension UITableView: AdapterProtocol {
    func setAdapter<M, T, V>(_ adapter: CommonAdapter<M, T, V>) where T: UIView, T: NibLoadable, T: Reusable {
        self.delegate = adapter as? UITableViewDelegate
        self.dataSource = adapter as? UITableViewDataSource
        reloadData()
    }

    func aReloadData() {
        self.reloadData()
    }

}
extension UICollectionView: AdapterProtocol {
    func aReloadData() {
        self.reloadData()
    }


    func setAdapter<M, T, V>(_ adapter: CommonAdapter<M, T, V>) where T: UIView, T: NibLoadable, T: Reusable {
        self.delegate = adapter as? UICollectionViewDelegate
        self.dataSource = adapter as? UICollectionViewDataSource
        reloadData()
    }
}
public extension UIView {
    /// 设置单次点击事件
    func setOnClick(target: Any?, action: Selector?) {
        //设置可交互
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }

    func removeSubviews() {
        _ = subviews.map({ view in
            view.removeFromSuperview()
        })
    }
}
