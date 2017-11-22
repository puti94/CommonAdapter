//
//  CommonCollectionAdapter.swift
//  Test
//
//  Created by puti on 2017/10/7.
//  Copyright © 2017年 puti. All rights reserved.
//
import UIKit
class CollectionAdapter<M, T:XCollectionCell>: CommonAdapter<M, T, UICollectionView>, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var columnCount: Int!
    var cellWidth: CGFloat!
    var headerView: UIView? {
        didSet {
            view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        }
    }
    
    /// 构造方法
    ///
    /// - Parameters:
    ///   - collectionView: 传入UICollectionView
    ///   - datas: 数据源
    ///   - columnCount: 列数量
    ///   - layout: <#layout description#>
    ///   - convert: <#convert description#>
    required init(_ collectionView: UICollectionView, datas: [M]? = nil, columnCount: Int, layout: UICollectionViewFlowLayout? = nil, convert: ((T, M, Int) -> Void)? = nil) {
        super.init()
        self.columnCount = columnCount
        self.mConvert = convert
        view = collectionView
        if datas != nil {
            self.datas = datas!
        }
        view.delegate = self
        view.dataSource = self
        view.register(cellType: T.self)

        var mLayout = layout
        if mLayout == nil {
            mLayout = UICollectionViewFlowLayout()
            //列间距
            mLayout!.minimumInteritemSpacing = 1
            //行间距
            mLayout!.minimumLineSpacing = 0.5
//            mLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        }

        //Collection内容宽度
        let contentWidth = view.bounds.width - mLayout!.sectionInset.left - mLayout!.sectionInset.right - (mLayout!.minimumInteritemSpacing * CGFloat(columnCount))
        //预设Cell宽度
        cellWidth = contentWidth / CGFloat(columnCount)
        //给CollectionCell传入宽度

        mLayout!.estimatedItemSize = CGSize(width: cellWidth, height: 100)
        view.collectionViewLayout = mLayout!
    }

    override func setNewDatas(_ datas: [M]) {
        super.setNewDatas(datas)
        //修复7P真机莫名奇妙的BUG 重新刷新一次
        view.reloadData()
    }

    @objc func action() {
        view.reloadData()
    }


    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: T = collectionView.dequeueReusableCell(for: indexPath)
        cell.cellWidth = cellWidth
        setCellView(cell, datas[indexPath.row], indexPath.row)
        cell.click = { tag in
            if self.itemChildClick != nil {
                self.itemChildClick!(tag, indexPath.row, self.datas[indexPath.row])
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if itemClick != nil {
            itemClick!(indexPath.row, datas[indexPath.row])
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        print("referenceSizeForHeaderInSection", section)
        if section == 0 && headerView != nil {
            return CGSize(width: headerView!.bounds.width, height: headerView!.bounds.height)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("viewForSupplementaryElementOfKind")
        if kind == UICollectionElementKindSectionHeader && headerView != nil {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath)
            _ = header.subviews.map({ view in
                view.removeFromSuperview()
            })
            header.addSubview(headerView!)
            print("viewForSupplementaryElementOfKind", header.frame)
            return header
        }
        return UICollectionReusableView()
    }
}
