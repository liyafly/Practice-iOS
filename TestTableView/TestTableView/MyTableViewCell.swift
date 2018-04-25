//
//  MyTableViewCell.swift
//  TestTableView
//
//  Created by 李亚非 on 2018/4/18.
//  Copyright © 2018年 李亚非. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var MyImageView: UIImageView!
  class  func MyCell(_ tableView: UITableView) -> MyTableViewCell {
    var cell: MyTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell") as? MyTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("MyTableViewCell", owner: self, options: nil)?.first as! MyTableViewCell
        }
    return cell!
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
