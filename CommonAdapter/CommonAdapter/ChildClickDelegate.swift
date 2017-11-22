//
//  ChildClickDelegate.swift
//
//
//  Created by puti on 2017/10/9.
//  Copyright © 2017年 puti. All rights reserved.
//

import Foundation

protocol ChildClickDelegate {
    var click: ((Int) -> Void)? { get set }
}
