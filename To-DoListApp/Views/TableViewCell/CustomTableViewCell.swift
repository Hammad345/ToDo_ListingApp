//
//  CustomTableViewCell.swift
//  To-DoListApp
//
//  Created by Amaan Gillani on 14/08/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var taskNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
