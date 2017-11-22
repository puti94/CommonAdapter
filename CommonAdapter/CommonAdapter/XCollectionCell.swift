//
//  BaseCollectionCell.swift
//  Test
//
//  Created by puti on 2017/10/7.
//  Copyright © 2017年 puti. All rights reserved.
//

import UIKit

class XCollectionCell: UICollectionViewCell, NibReusable, ChildClickDelegate {
    var click: ((Int) -> Void)?
    var cellWidth: CGFloat = 100

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size: CGSize = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        // 获取自适应size
        var newFrame: CGRect = layoutAttributes.frame
        newFrame.size.height = size.height
        newFrame.size.width = cellWidth
        // 不同屏幕适配
        layoutAttributes.frame = newFrame
        return layoutAttributes

    }

}
