
# CommonAdapter
   用惯了Android 封装的万能适配器, 非常不习惯IOS UITableView和UICollectionView又要设置数据源又要设置协议等各种复杂的操作，封装了个适配器。由于视图操作没有和数据源分离，严格来讲不能叫做Adapter,I don`t care

- 使用:把项目中的CommonAdapter文件夹拖到项目中
  
   ```
   简单用法
   需要一个UITableViewCell类似于Android的ViewHolder
   class TableViewCell: XTableViewCell {
    @IBOutlet weak var label: UILabel!
  }
  //在viewDidAppear方法里面创建TableAdapter实例
  TableAdapter<String, TableViewCell>(tableView,datas: data, convert: { cell, item, position in
            print(item)
            cell.label.text = item
  })
   具体用法看Demo
   
   ```
## 效果图
  ![效果图](https://github.com/puti94/CommonAdapter/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%206%20-%202017-11-22%20at%2016.51.26.png)
  ![效果图](https://github.com/puti94/CommonAdapter/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%206%20-%202017-11-22%20at%2016.51.30.png)
  ![效果图](https://github.com/puti94/CommonAdapter/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%206%20-%202017-11-22%20at%2016.51.34.png)

