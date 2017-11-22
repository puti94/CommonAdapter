//
//  ViewController.swift
//  CommonAdapter
//
//  Created by puti on 2017/11/22.
//  Copyright © 2017年 puti. All rights reserved.
//

import UIKit
// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
// 屏幕高度
let kScreenW = UIScreen.main.bounds.width
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var tableView2: UITableView!

    @IBOutlet weak var collectionView: UICollectionView!

    var tableAdapter: TableAdapter<String, TableViewCell>!
    var tableAdapter2: TableAdapter<String, TableViewCell>!
    var collectionAdapter: CollectionAdapter<String, CollectionViewCell>!
    var headerView: UILabel!
    var data: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<100 {
            if i % 3 == 0 {
                data.append("第\(i)行第\(i)行第\(i)行第\(i)行第\(i)行第\(i)行第\(i)行第\(i)行第\(i)行第\(i)行")
            } else {
                data.append("第\(i)行")
            }
        }
        tableView.backgroundColor = .gray


        headerView = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 100))
        headerView.backgroundColor = .blue
        headerView.text = "我是Header"
        headerView.textAlignment = .center
        headerView.textColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.isHidden = false
        tableView2.isHidden = true
        collectionView.isHidden = true
        tableAdapter = TableAdapter<String, TableViewCell>(tableView, datas: data, convert: { cell, item, position in
            print(item)
            cell.label.text = item
        })
        collectionAdapter = CollectionAdapter(collectionView, datas: data, columnCount: 2, convert: { cell, item, position in
            print(item)
            cell.label.text = item
        })

        tableAdapter2 = TableAdapter<String, TableViewCell>(tableView2)
        tableView2.register(cellType: TableView2Cell.self)
        tableAdapter2.cellForPosition = { tableView, item, position in
            if position % 4 == 0 {
                let cell: TableView2Cell = tableView.dequeueReusableCell(for: IndexPath(row: position, section: 1))
                cell.click = { tag in
                    print("点击了", tag, position, item)
                }
                return cell
            } else {
                let cell: TableViewCell = tableView.dequeueReusableCell(for: IndexPath(row: position, section: 1))
                cell.label.text = item
                return cell
            }
        }


        collectionAdapter.headerView = headerView
        collectionAdapter.itemClick = { position, item in
            print("点击了", item)
        }

        tableAdapter.itemClick = { position, item in
            print("点击了", item)
        }
    }

    @IBAction func change(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0 {
            tableView.isHidden = false
            tableView2.isHidden = true
            collectionView.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            tableView.isHidden = true
            tableView2.isHidden = true
            collectionView.isHidden = false
        } else if sender.selectedSegmentIndex == 2 {
            tableAdapter2.setNewDatas(data)
            tableView.isHidden = true
            tableView2.isHidden = false
            collectionView.isHidden = true
        }
    }
}

