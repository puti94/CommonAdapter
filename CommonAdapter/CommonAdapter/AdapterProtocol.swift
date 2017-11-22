//
//  AdapterProtocol.swift
//  Test
//
//  Created by puti on 2017/10/7.
//  Copyright © 2017年 puti. All rights reserved.
//

import Foundation
protocol AdapterProtocol {
    func aReloadData()
    func setAdapter<M, T:NibReusable, V>(_ adapter: CommonAdapter<M, T, V>)
}
