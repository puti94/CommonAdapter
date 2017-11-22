//
//  XTableViewCell.swift
//
//
//  Created by puti on 2017/10/9.
//  Copyright © 2017年 puti. All rights reserved.
//

import Foundation
import UIKit
class XTableViewCell: UITableViewCell, NibReusable, ChildClickDelegate {
    var click: ((Int) -> Void)?

}
